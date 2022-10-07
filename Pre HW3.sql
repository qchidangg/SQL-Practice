-- Create database
create table actor (
id integer primary key, fname varchar(50), lname varchar(50), gender bit );
Create table movie (
id integer primary key, name varchar(50), year varchar(10));
create table directors(
id integer primary key, fname varchar(50), lname varchar(50));
create table cats (
pid int , FOREIGN KEY(pid) REFERENCES actor(id), 
mid int , FOREIGN KEY(mid) REFERENCES movie(id),
role varchar(100));
create table movie_directors(
did int , FOREIGN KEY(did) REFERENCES directors(id), 
mid int , FOREIGN KEY(mid) REFERENCES movie(id));
create table genre (
mid int , FOREIGN KEY(mid) REFERENCES movie(id),
genre varchar(50))
-- Q1: List the first and last names of the director(s) of ‘The Shawshank Redemption’.
select fname,lname
from directors d1
join movie_directors d2 on d1.id=d2.did
join movie m on m.id= d2.mid
where name='The Shawshank Redemption';
-- Q2: Compute the number of roles that were cast in ‘Elastico: Experiment 345’.
select count(role)
from casts c
join movie m on m.id=c.mid
where name='Elastico: Experiment 345';
-- Q3: Compute how many actors appeared in a movie released in 1990.
select count(distinct a.id)
from actor a
join casts c on c.pid= a.id
join movie m on m.id= c.mid
where year=1990;
-- Q4: Compute how many actors appeared in a movie released in 1990 and also in a movie released in 2010. 
select count(distinct a.id )
from actor a
inner join casts c1 on c1.pid = a.id
inner join casts c2 on c2.pid = a.id
inner join movie m1 on c1.mid = m1.id
inner join movie m2 on c2.mid = m2.id 
where m1.year= 1990 and m2.year=2010; 
-- Q5: Return the number of actors who have played two distinct roles in the same movie. (If an actor has played multiple roles in several movies, they should be counted only once.)
SELECT COUNT(DISTINCT c1.pid)
  FROM casts as c1, casts as c2
 WHERE c1.role<>c2.role AND c1.pid=c2.pid AND c1.mid=c2.mid



