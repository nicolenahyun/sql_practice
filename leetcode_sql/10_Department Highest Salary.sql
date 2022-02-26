Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key column for this table.
departmentId is a foreign key of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of a department and its name.
 

Write an SQL query to find employees who have the highest salary in each of the departments.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

--------------------------------------------------------------------
Method 1:
SELECT D.name AS Department, E.name AS Employee, E.salary AS Salary
FROM Department D
JOIN Employee E ON D.id=E.departmentId
WHERE E.salary = (SELECT MAX(salary) FROM Employee E2 WHERE E2.departmentId=E.departmentId);

*** 이 방법은 중복되는 결과가 출력이 안됨(생각해볼 것)
SELECT D.name AS Department, E.name AS Employee, E.max_salary AS Salary
FROM (SELECT name, MAX(salary) AS max_salary, departmentId
     FROM Employee
     GROUP BY departmentId) E
JOIN Department AS D ON E.departmentId=D.id;

Method 2:
SELECT Department.Name AS Department, Employee.Name AS Employee, Max(Salary) OVER (PARTITION BY Department ORDER BY Salary) AS Salary
FROM Employee 
JOIN Department ON Employee.DepartmentId = Department.Id

Method 3:
SELECT L1.Department, L1.Employee, L1.Salary
FROM
(SELECT Department.Name AS Department, Employee.Name AS Employee, Salary
FROM Employee JOIN Department ON Employee.DepartmentId = Department.Id) AS L1,
(SELECT Department.Name AS Department, Employee.Name AS Employee, Salary
FROM Employee JOIN Department ON Employee.DepartmentId = Department.Id) AS L2
WHERE L1.Salary > L2.Salary 
AND L1.Department = L2.Department
