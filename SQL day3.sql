CREATE DATABASE company;
USE company;
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);

INSERT INTO employee (emp_id, first_name, last_name, department, salary, hire_date) VALUES
(1, 'John', 'Doe', 'HR', 50000.00, '2022-01-10'),
(2, 'Jane', 'Smith', 'IT', 75000.00, '2021-03-15'),
(3, 'Mike', 'Brown', 'Finance', 62000.00, '2020-07-21'),
(4, 'Emily', 'Davis', 'Marketing', 58000.00, '2023-02-05'),
(5, 'Robert', 'Johnson', 'IT', 79000.00, '2019-11-11'),
(6, 'Linda', 'Wilson', 'HR', 52000.00, '2022-06-18'),
(7, 'David', 'Lee', 'Finance', 66000.00, '2020-10-03'),
(8, 'Sophia', 'Taylor', 'Marketing', 61000.00, '2023-08-22'),
(9, 'Chris', 'Anderson', 'IT', 81000.00, '2018-12-01'),
(10, 'Olivia', 'Martin', 'HR', 54000.00, '2021-04-30');

select * from employee;
DELETE FROM employee
WHERE emp_id = NULL;


-- Select employees from IT department with salary > 60000, ordered by salary
SELECT first_name, last_name, department, salary
FROM employee
WHERE department = 'IT' AND salary > 60000
ORDER BY salary DESC;

-- Group by department and get average salary
SELECT department, AVG(salary) AS avg_salary
FROM employee
GROUP BY department;

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO department (dept_id, dept_name, location) VALUES
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'Chicago'),
(4, 'Marketing', 'Los Angeles'),
(5, 'Operations', 'Seattle');


-- INNER JOIN: Only matching records
SELECT e.first_name, e.department, d.location
FROM employee e
INNER JOIN department d ON e.department = d.dept_name;

-- LEFT JOIN: All from employee, matched from department
SELECT e.first_name, d.location
FROM employee e
LEFT JOIN department d ON e.department = d.dept_name;

-- RIGHT JOIN: All from department, matched from employee
SELECT e.first_name, d.dept_name
FROM employee e
RIGHT JOIN department d ON e.department = d.dept_name;


-- Get employees whose salary is above average
SELECT first_name, salary
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);

-- Total salary paid in Marketing
SELECT SUM(salary) AS total_salary
FROM employee
WHERE department = 'Marketing';

-- Department-wise employee count
SELECT department, COUNT(*) AS num_employees
FROM employee
GROUP BY department;

-- Create a view for IT department salaries
CREATE VIEW it_employees AS
SELECT emp_id, first_name, salary
FROM employee
WHERE department = 'IT';

-- Now you can use it like a table
SELECT * FROM it_employees;

-- Add index on department (useful for WHERE, JOIN, GROUP BY)
CREATE INDEX idx_department ON employee(department);

-- Index on salary for faster filtering/sorting
CREATE INDEX idx_salary ON employee(salary);

