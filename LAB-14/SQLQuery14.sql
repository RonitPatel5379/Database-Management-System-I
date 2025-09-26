--Part – A:

--Create below table with following constraints
--1. Do not allow SPI more than 10
--2. Do not allow Bklog less than 0.
--3. Enter the default value as ‘General’ in branch to all new records IF no other value is specified.
--4. Try to update SPI of Raju from 8.80 to 12.
--5. Try to update Bklog of Neha from 0 to -1

CREATE TABLE STU_MASTER (
    Rno INT PRIMARY KEY,
    Name VARCHAR(50),
    Branch VARCHAR(20) DEFAULT 'General',
    SPI DECIMAL(4,2) CHECK (SPI <= 10),
    Bklog INT CHECK (Bklog >= 0)
);
INSERT INTO STU_MASTER VALUES 
(101, 'Raju', 'CE', 8.80, 0),
(102, 'Amit', 'CE', 2.20, 3),
(103, 'Sanjay', 'ME', 1.50, 6),
(104, 'Neha', 'EC', 7.65, 0),
(105, 'Meera', 'EE', 5.52, 2),
(106, 'Mahesh', DEFAULT, 4.50, 3);

UPDATE STU_MASTER SET SPI = 12 WHERE Name = 'Raju'
UPDATE STU_MASTER SET Bklog = -1 WHERE Name = 'Neha';

--Part – B: Create table as per following schema with proper validation and try to insert data which violate your validation.

-- 1. Emp_details(Eid, Ename, Did, Cid, Salary, Experience)
--    Dept_details(Did, Dname)
--    City_details(Cid, Cname)

CREATE TABLE Dept_details (
    Did INT PRIMARY KEY,
    Dname VARCHAR(50) NOT NULL
);
CREATE TABLE City_details (
    Cid INT PRIMARY KEY,
    Cname VARCHAR(50) NOT NULL
);
CREATE TABLE Emp_details (
    Eid INT PRIMARY KEY,
    Ename VARCHAR(50) NOT NULL,
    Did INT,
    Cid INT,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    Experience INT CHECK (Experience >= 0),
    CONSTRAINT fk_dept FOREIGN KEY (Did) REFERENCES Dept_details(Did),
    CONSTRAINT fk_city FOREIGN KEY (Cid) REFERENCES City_details(Cid)
);
INSERT INTO Dept_details VALUES (1, 'HR'),(2, 'IT');
INSERT INTO City_details VALUES (101, 'Surat'),(102, 'Ahmedabad');
INSERT INTO Emp_details VALUES (1001, 'Ajay', 1, 101, 35000, 3),(1002, 'Meera', 2, 102, 42000, 5);

INSERT INTO Emp_details VALUES (1003, 'Ravi', 1, 101, -20000, 2);
INSERT INTO Emp_details VALUES (1004, 'Neha', 2, 101, 30000, -1);
INSERT INTO Emp_details VALUES (1005, 'Sanjay', 5, 101, 28000, 1);
INSERT INTO Emp_details VALUES (1006, 'Mahesh', 1, 999, 25000, 2);

--Part – C: Create table as per following schema with proper validation and try to insert data which violate your validation.
-- 1. Emp_info(Eid, Ename, Did, Cid, Salary, Experience)
--    Dept_info(Did, Dname)
--    City_info(Cid, Cname, Did))
--    District(Did, Dname, Sid)
--    State(Sid, Sname, Cid)
--    Country(Cid, Cname)
-- 2. Insert 5 records in each table.
-- 3. Display employeename, departmentname, Salary, Experience, City, District, State and country of all employees

CREATE TABLE Country2(
    Cid INT PRIMARY KEY,
    Cname VARCHAR(50) NOT NULL
);
CREATE TABLE State1(
    Sid INT PRIMARY KEY,
    Sname VARCHAR(50) NOT NULL,
    Cid INT,
    CONSTRAINT fk_country FOREIGN KEY (Cid) REFERENCES Country(Cid)
);
CREATE TABLE District1(
    Did INT PRIMARY KEY,
    Dname VARCHAR(50) NOT NULL,
    Sid INT,
    CONSTRAINT fk_state FOREIGN KEY (Sid) REFERENCES State(Sid)
);
CREATE TABLE Dept_info1(
    Did INT PRIMARY KEY,
    Dname VARCHAR(50) NOT NULL
);
CREATE TABLE City_info1(
    Cid INT PRIMARY KEY,
    Cname VARCHAR(50) NOT NULL,
    Did INT,
    CONSTRAINT fk_district FOREIGN KEY (Did) REFERENCES District(Did)
);
CREATE TABLE Emp_info2(
    Eid INT PRIMARY KEY,
    Ename VARCHAR(50) NOT NULL,
    Did INT,
    Cid INT,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    Experience INT CHECK (Experience >= 0),
    CONSTRAINT fk_dept FOREIGN KEY (Did) REFERENCES Dept_info(Did),
    CONSTRAINT fk_city FOREIGN KEY (Cid) REFERENCES City_info(Cid)
);

-- Country
INSERT INTO Country VALUES 
(1, 'India'),
(2, 'USA'),
(3, 'UK'),
(4, 'Canada'),
(5, 'Australia');

-- State
INSERT INTO State VALUES 
(101, 'Gujarat', 1),
(102, 'Maharashtra', 1),
(103, 'California', 2),
(104, 'Ontario', 4),
(105, 'Queensland', 5);

-- District
INSERT INTO District VALUES 
(201, 'Surat', 101),
(202, 'Mumbai', 102),
(203, 'Los Angeles', 103),
(204, 'Toronto', 104),
(205, 'Brisbane', 105);

-- Department
INSERT INTO Dept_info VALUES 
(301, 'HR'),
(302, 'IT'),
(303, 'Finance'),
(304, 'Sales'),
(305, 'Marketing');

-- City
INSERT INTO City_info VALUES 
(401, 'Adajan', 201),
(402, 'Andheri', 202),
(403, 'Santa Monica', 203),
(404, 'Downtown Toronto', 204),
(405, 'South Brisbane', 205);

-- Employee
INSERT INTO Emp_info2 VALUES 
(501, 'Ajay', 301, 401, 35000, 3),
(502, 'Meera', 302, 402, 42000, 5),
(503, 'Sanjay', 303, 403, 28000, 2),
(504, 'Neha', 304, 404, 50000, 4),
(505, 'Mahesh', 305, 405, 60000, 6);