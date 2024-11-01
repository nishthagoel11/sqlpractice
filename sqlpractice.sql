
--Creating employee_details table
CREATE TABLE employee_details (
empid INT PRIMARY KEY,
first_name VARCHAR(25),
last_name VARCHAR(25)
);

--Creating manager_details table
CREATE TABLE manager_details (
manager_name VARCHAR(25),
empid INT,
FOREIGN KEY (empid) REFERENCES employee_details(empid)
);

--Inserting Values
--Inserting data into employee_details
INSERT INTO employee_details (empid, first_name, last_name) 
VALUES 
(1, 'Rahul', 'Sharma'),
(2, 'Priya', 'Kumar'),
(3, 'Amit', 'Patel'),
(4, 'Sneha', 'Mehta'),
(5, 'Rohit', 'Verma'),
(6, 'Manav', 'Agarwal'),
(7, 'Riya', 'Bansal')
(8, 'Keshav', 'Goyal');

--Inserting data into manager_details
INSERT INTO manager_details (manager_name, empid)
VALUES 
('Mahesh', 1),
('Mahesh', 2),
('Mahesh', 3),
('Kartik', 4),
('Kartik', 5),
('Shreya',6),
('Shreya',8);

--Query 1: Get All Employees Under Each Manager

SELECT manager_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM manager_details
JOIN employee_details ON manager_details.empid = employee_details.empid
ORDER BY manager_name;

--Query 2: Count of Employees Under a Specific Manager (example-Kartik)

SELECT manager_name, COUNT(empid) AS employee_count
FROM manager_details
WHERE manager_name = 'Kartik'
GROUP BY manager_name;

--Query 3: Get All Managers Details (Distinct List of Managers)

SELECT DISTINCT manager_name
FROM manager_details;

--Query 4: Find Any Employee Who Has Not Been Assigned a Manager

SELECT empid, first_name, last_name
FROM employee_details
WHERE empid NOT IN (SELECT empid FROM manager_details);

--Query 5. Create a Function to Get Full Name
--This function concatenates the first and last names of an employee.

DELIMITER $$
CREATE FUNCTION get_fullname(emp_id INT) 
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
RETURN (
SELECT CONCAT(first_name, ' ', last_name)
FROM employee_details
WHERE empid = emp_id
);
END $$
DELIMITER ;

--Query to test the 'get_fullname' Function

SELECT get_fullname(1); 


