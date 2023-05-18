-- Creating the EmployeeDetails table
CREATE TABLE EmployeeDetails (
  EmpId INT PRIMARY KEY,
  FullName VARCHAR(100),
  ManagerId INT,
  DateOfJoining DATE,
  City VARCHAR(50)
);

-- Creating the EmployeeSalary table
CREATE TABLE EmployeeSalary (
  EmpId INT PRIMARY KEY,
  Project VARCHAR(100),
  Salary DECIMAL(10, 2),
  Variable DECIMAL(10, 2)
);

-- Insert values into EmployeeDetails
INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES
    (1, 'John Doe', NULL, '2022-01-01', 'New York'),
    (2, 'Jane Smith', 1, '2022-02-15', 'Los Angeles'),
    (3, 'Robert Johnson', 1, '2022-03-20', 'Chicago');

-- Insert values into EmployeeSalary
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES
    (1, 'Project A', 5000.00, 1000.00),
    (2, 'Project B', 6000.00, 1500.00),
    (3, 'Project C', 7000.00, 2000.00);
--1. SQL Query to fetch records that are present in one table but not in another table.

SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary)


--2. SQL query to fetch all the employees who are not working on any project.

SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary WHERE Project IS NOT NULL)


--3. SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.

SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020


--4. Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.

SELECT *
FROM EmployeeDetails
WHERE EmpId IN (SELECT EmpId FROM EmployeeSalary)


--5. Write an SQL query to fetch a project-wise count of employees.

SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project


--6. Fetch employee names and salaries even if the salary value is not present for the employee.

SELECT EmployeeDetails.FullName, EmployeeSalary.Salary
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId


--7. Write an SQL query to fetch all the Employees who are also managers.

SELECT e1.*
FROM EmployeeDetails e1
INNER JOIN EmployeeDetails e2 ON e1.EmpId = e2.ManagerId


--8. Write an SQL query to fetch duplicate records from EmployeeDetails.

SELECT EmpId, FullName, COUNT(*) AS DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId, FullName
HAVING COUNT(*) > 1


--9. Write an SQL query to fetch only odd rows from the table.

SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY id) AS row_num
  FROM EmployeeDetails
) AS temp
WHERE row_num % 2 <> 0


--10. Write a query to find the 3rd highest salary from a table without top or limit keyword.

SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY id) AS row_num
  FROM EmployeeDetails
) AS temp
WHERE row_num % 2 <> 0