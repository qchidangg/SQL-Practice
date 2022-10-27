
create table author (
name varchar(50), homepage varchar(50), id integer primary key , unique(name));
create table publication(
title varchar(50), year int, pubid int primary key, pubkey varchar(50), unique(pubkey));
create table article(
month varchar(10), pubid int primary key, volume varchar(50), number varchar(50), journal varchar(50),
FOREIGN KEY (pubid) REFERENCES publication(pubid));
Create table authored (
id integer, FOREIGN KEY(id) REFERENCES author(id),
pubid integer, FOREIGN KEY(pubid) REFERENCES publication(pubid));
create table book(
pubid int primary key, isbn varchar(50), publisher varchar(50),
FOREIGN KEY (pubid) REFERENCES publication(pubid));
create table incollection(
pubid int primary key, booktitle varchar(50), isbn varchar(50),publisher varchar(50),
FOREIGN KEY (pubid) REFERENCES publication(pubid));
create table inproceedings(
pubid int primary key, booktitle varchar(50),editor varchar(50),
FOREIGN KEY (pubid) REFERENCES publication(pubid));



create table country(
code char(3) primary key, name char(52), continent char(60), region char(26), surfacearea real,
population int, localname char(45), headofstate char(60), code2 char(2), gnp real, capital int,
gnpold real, lifeexpectancy real , indepyear int);
create table city(
id int primary key , name char(35), district char(20), population int, countrycode char(3),
FOREIGN KEY (countrycode) REFERENCES country(code));
create table countrylanguage(
countrycode char(3), language char(30) primary key, isofficial char(2), percentage real,
FOREIGN KEY (countrycode) REFERENCES country(code));

-- Q1 (IMDB): What is the largest number of distinct roles any one actor has in ‘The Muppet Movie’?
SELECT max(rolesnum)
from (select C.pid, COUNT(DISTINCT(C.role)) AS RolesNum
FROM Casts C,Movie M
WHERE C.mid=M.id AND M.name= 'The Muppet Movie'
GROUP BY pid
ORDER BY RolesNum DESC) as T;
-- Q2 (DBLP): How many authors have published an article in January but don’t have a homepage? Submit the query in file Q2.sql.
Select count(distinct a1.name)
from author a1
join authored a2
on a1.id=a2.id
join article a3
on a2.pubid=a3.pubid
where month='January' and homepage is null ;
-- What is the name of the city that has the largest population in a country which has exactly 11 languages
select cty.name 
from `city` cty 
group by cty.countryCode
having max(cty.Population) in ( 
select max(cty.Population)
from city cty
group by cty.countryCode 
having cty.name in (
select name from city where countryCode in ( 
select col.countrycode from countrylanguage col 
group by col countrycode
having count(col.Language)=11)));
-- -- Q4 How many different actors played at least one role in the movie ‘The Departed’ ?
select count(actor)
from (
select distinct a.id as actor
from actor a
join casts c
on c.pid=a.id
join movie m
on c.mid=m.id
where m.name='The Departed'
group by a.id
having count(c.role)>=1) as T;
-- Q5 Who played Optimus Prime in Transformers: Dark of the Moon? Return their first and last name.
select a.fname,a.lname
from actor a
join casts c
on c.pid=a.id
join movie m
on m.id= c.mid
where c.role='Optimus Prime' and m.name='Transformers: Dark of the Moon';
-- Q6 (WorldDB): What country has French as an official language and a total population greater than 40,000 but lower than 100,000? 
-- Return the name of the country.
select c1.name
from country c1
join countrylanguage c2
on c1.code=c2.countrycode
where c1.population>40000 and c1.population <100000 and c2.language='French' and c2.isofficial='T'




