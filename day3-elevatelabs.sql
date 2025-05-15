show databases;
use employees;
-- a. SELECT, WHERE, ORDER BY, GROUP BY
SELECT d.dept_name, COUNT(de.emp_no) AS employee_count
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' -- Current department assignments
GROUP BY d.dept_name
HAVING employee_count > 10000
ORDER BY employee_count DESC;

-- b. LEFT JOIN: Employees with or without a department
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no = de.emp_no
LEFT JOIN departments d ON de.dept_no = d.dept_no
LIMIT 15;

-- b2. RIGHT JOIN: Departments with or without employees
SELECT d.dept_name, COUNT(de.emp_no) AS Employee_Count
FROM dept_emp de
RIGHT JOIN departments d ON de.dept_no = d.dept_no
GROUP BY d.dept_name;

-- c. subquery - employees w/ salary > 60,000

SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s on e.emp_no = s.emp_no
WHERE s.salary > (SELECT 60000)
LIMIT 15;

-- c. Subquery: Employees with salary above 60000
SELECT e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary > (SELECT 16000)
ORDER BY s.salary;

-- d. Aggregate Fuctions: using AVG functions to show average salary of a department
SELECT d.dept_name AS DEPT_NAME, AVG(s.salary) AS average_salary
from departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_name;



-- e. Create View: Department employee count
CREATE VIEW dept_employee_count AS
SELECT d.dept_name, COUNT(de.emp_no) AS employee_count
FROM departments d
LEFT JOIN dept_emp de ON d.dept_no = de.dept_no
GROUP BY d.dept_name;

SELECT * FROM dept_employee_count;








-- f. Optimize with Index
CREATE INDEX idx_dept_emp_no ON dept_emp(emp_no);
