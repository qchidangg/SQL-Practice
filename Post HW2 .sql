-- Q1: During which months of the year have companies from Japan sold products? Your query should return a list of the appropriate months.
SELECT S.MONTH
FROM SALES S 
JOIN PRODUCT P ON S.PNAME=P.PNAME
JOIN COMPANY C ON C.CNAME=P.MANUFACTURER
WHERE C.COUNTRY='Japan' 
group by s.month
having sum(s.sold)>0;
-- Q2: Return a list of all employee names and the names of their managers. The first column in your answer should give the name of the employee, and the second column the name of the corresponding manager. Do not omit any employees even if they have no manager.
SELECT 	e1.name AS Employee_Name, e2.name AS Manager_Name
	FROM Employees e1 LEFT JOIN Employees e2
	ON e1.managerID = e2.empID;
-- Q3: Compute the total number of sales for each product, only for those products that have sold more than 3 items in total. In your result, the first column should have the product name, and the second column should list the number of sold items for that product.
SELECT pname, sum(sold)
from sales
group by pname
having sum(sold)>3;
-- Q4: For each country, compute how many ‘Photography’ products it produces. In your result, the first column should have the name of the country, and the second column the number of photography products for that country.
SELECT c.country, count(p.category)
from product P
join company C on p.manufacturer= c.cname
where category='Photography'
group by c.country;
-- Q5: For each category, compute how many countries produce products in that category. In your result, the first column should have the category, and the second column should have the appropriate number.
SELECT p.category, COUNT(distinct c.country)
FROM Product P
join company c on p.manufacturer= c.cname
GROUP BY p.category;
-- Q6: For each project, list how many employees are assigned to it. In your result, the first column should list all projects, and the second column should have the appropriate numbers.
SELECT Project, COUNT(empID) as Total
FROM projects
GROUP BY Project;
-- Q7: For each product, find the month during which the product had the most sales out of the year. For example, if out of all the months of the year, Gizmo had the most sales in February, then the tuple (Gizmo, February) should be in the result.
SELECT pname, month
  FROM Sales as a
 WHERE sold=(SELECT max(sold)
               FROM Sales as b
              WHERE a.pname=b.pname)
