--Sub Queries

--STUDENT_DATA 
--Rno Name City DID
--101 Raju Rajkot 10
--102 Amit Ahmedabad 20
--103 Sanjay Baroda 40
--104 Neha Rajkot 20
--105 Meera Ahmedabad 30
--106 Mahesh Baroda 10

                    CREATE TABLE STUDENT_DATA (
                       RNO INT,
                       NAME VARCHAR(50),
                       CITY VARCHAR(50),
                       DID INT );

                    INSERT INTO STUDENT_DATA(RNO,NAME,CITY,DID) VALUES(101,'RAJU','RAJKOT',10)
                    INSERT INTO STUDENT_DATA(RNO,NAME,CITY,DID) VALUES(102,'AMIT','AHMEDABAD',20)
                    INSERT INTO STUDENT_DATA(RNO,NAME,CITY,DID) VALUES(103,'SANJAY','BARODA',40)
                    INSERT INTO STUDENT_DATA(RNO,NAME,CITY,DID) VALUES(104,'NEHA','RAJKOT',20)
                    INSERT INTO STUDENT_DATA(RNO,NAME,CITY,DID) VALUES(105,'MEERA','AHMEDABAD',30)
                    INSERT INTO STUDENT_DATA(RNO,NAME,CITY,DID) VALUES(106,'MAHESH','BARODA',10)
                    SELECT * FROM STUDENT_DATA


--DEPARTMENT 
--DID DName
--10 Computer
--20 Electrical
--30 Mechanical
--40 Civil

                    CREATE TABLE DEPARTMENT (
                       DID INT,
                       DNAME VARCHAR(50) );

                    INSERT INTO DEPARTMENT(DID,DNAME) VALUES(10,'COMPUTER')
                    INSERT INTO DEPARTMENT(DID,DNAME) VALUES(20,'ELECTRICAL')
                    INSERT INTO DEPARTMENT(DID,DNAME) VALUES(30,'MECHANICAL')
                    INSERT INTO DEPARTMENT(DID,DNAME) VALUES(40,'CIVIL')
                    SELECT * FROM DEPARTMENT


--ACADEMIC 
--RNO SPI BKLOG
--101 8.8 0
--102 9.2 2
--103 7.6 1
--104 8.2 4
--105 7.0 2
--106 8.9 3

                    CREATE TABLE ACADEMIC (
                       RNO INT,
                       SPI DECIMAL(4,2),
                       BKLOG INT );

                    INSERT INTO ACADEMIC(RNO,SPI,BKLOG) VALUES(101,8.8,0)
                    INSERT INTO ACADEMIC(RNO,SPI,BKLOG) VALUES(102,9.2,2)
                    INSERT INTO ACADEMIC(RNO,SPI,BKLOG) VALUES(103,7.6,1)
                    INSERT INTO ACADEMIC(RNO,SPI,BKLOG) VALUES(104,8.2,4)
                    INSERT INTO ACADEMIC(RNO,SPI,BKLOG) VALUES(105,7.0,2)
                    INSERT INTO ACADEMIC(RNO,SPI,BKLOG) VALUES(106,8.9,3)
                    SELECT * FROM ACADEMIC


--Part – A:
--1.Display details of students who are from computer department.
    SELECT * FROM STUDENT_DATA WHERE DID = (SELECT DID FROM DEPARTMENT WHERE DNAME='COMPUTER')
--2.Displays name of students whose SPI is more than 8.
    SELECT NAME FROM STUDENT_DATA WHERE RNO IN (SELECT RNO FROM ACADEMIC WHERE SPI > 8)
--3.Display details of students of computer department who belongs to Rajkot city.
    SELECT * FROM STUDENT_DATA WHERE DID = (SELECT DID FROM DEPARTMENT WHERE DNAME='COMPUTER') AND CITY = 'RAJKOT'
--4.Find total number of students of electrical department.
    SELECT  COUNT(*) AS TOTAL_STU FROM STUDENT_DATA WHERE DID = (SELECT DID FROM DEPARTMENT WHERE DNAME='ELECTRICAL')
--5.Display name of student who is having maximum SPI.
    SELECT NAME FROM STUDENT_DATA WHERE RNO = (SELECT RNO FROM ACADEMIC WHERE SPI = (SELECT MAX(SPI) FROM ACADEMIC)) 
--6.Display details of students having more than 1 backlog.
    SELECT * FROM STUDENT_DATA WHERE RNO IN(SELECT RNO FROM ACADEMIC WHERE BKLOG > 1)

--Part – B:
--1.Display name of students who are either from computer department or from mechanical department.
    SELECT NAME FROM STUDENT_DATA WHERE DID IN (SELECT DID FROM DEPARTMENT WHERE DNAME IN('COMPUTER','MECHANICAL'))
--2.Display name of students who are in same department as 102 studying in.
    SELECT NAME FROM STUDENT_DATA WHERE DID = (SELECT DID FROM STUDENT_DATA WHERE RNO=102)

--Part – C:
--1.Display name of students whose SPI is more than 9 and who is from electrical department.
    SELECT NAME FROM STUDENT_DATA WHERE DID = (SELECT DID FROM DEPARTMENT WHERE DNAME='ELECTRICAL') AND RNO IN(SELECT RNO FROM ACADEMIC WHERE SPI > 9)
--2.Display name of student who is having second highest SPI.
    SELECT NAME FROM STUDENT_DATA WHERE RNO = (SELECT RNO FROM ACADEMIC)
--3.Display city names whose students SPI is 9.2
    SELECT CITY FROM STUDENT_DATA WHERE RNO IN(SELECT RNO FROM ACADEMIC WHERE SPI=9.2)
--4.Find the names of students who have more than the average number of backlogs across all students.
    SELECT NAME FROM STUDENT_DATA WHERE RNO IN (SELECT RNO FROM ACADEMIC WHERE BKLOG > (SELECT AVG(BKLOG) FROM ACADEMIC))
--5.Display the names of students who are in the same department as the student with the highest SPI.
    SELECT NAME FROM STUDENT_DATA WHERE DID IN (SELECT DID FROM STUDENT_DATA WHERE RNO = (SELECT RNO FROM ACADEMIC WHERE SPI = (SELECT MAX(SPI) FROM ACADEMIC)))

--SET Operators

--Part – A:
--Create below two tables as per following data.

--COMPUTER
--RollNo Name
--101 Ajay
--109 Haresh
--115 Manish

                    CREATE TABLE COMPUTER (
                       ROLLNO INT,
                       NAME VARCHAR(50) );

                    INSERT INTO COMPUTER(ROLLNO,NAME) VALUES(101,'AJAY')
                    INSERT INTO COMPUTER(ROLLNO,NAME) VALUES(109,'HARESH')
                    INSERT INTO COMPUTER(ROLLNO,NAME) VALUES(115,'MANISH')
                    SELECT * FROM COMPUTER

--ELECTRICAL
--RollNo Name
--105 Ajay
--107 Mahesh
--115 Manish

                    CREATE TABLE ELECTRICAL (
                       ROLLNO INT,
                       NAME VARCHAR(50) );

                    INSERT INTO ELECTRICAL(ROLLNO,NAME) VALUES(105,'AJAY')
                    INSERT INTO ELECTRICAL(ROLLNO,NAME) VALUES(107,'MAHESH')
                    INSERT INTO ELECTRICAL(ROLLNO,NAME) VALUES(115,'MANISH')
                    SELECT * FROM ELECTRICAL


--1.Display name of students who is either in Computer or in Electrical.
    SELECT NAME FROM COMPUTER UNION SELECT NAME FROM ELECTRICAL
--2.Display name of students who is either in Computer or in Electrical including duplicate data.
    SELECT NAME FROM COMPUTER UNION ALL SELECT NAME FROM ELECTRICAL
--3.Display name of students who is in both Computer and Electrical.
    SELECT NAME FROM COMPUTER INTERSECT SELECT NAME FROM ELECTRICAL
--4.Display name of students who are in Computer but not in Electrical.
    SELECT NAME FROM COMPUTER EXCEPT SELECT NAME FROM ELECTRICAL
--5.Display name of students who are in Electrical but not in Computer.
    SELECT NAME FROM ELECTRICAL EXCEPT SELECT NAME FROM COMPUTER
--6.Display all the details of students who are either in Computer or in Electrical.
    SELECT * FROM COMPUTER UNION SELECT * FROM ELECTRICAL
--7.Display all the details of students who are in both Computer and Electrical.
    SELECT * FROM COMPUTER INTERSECT SELECT * FROM ELECTRICAL


--Part – B:
--Create below two tables as per following data.

--EMP_DATA
--EID Name
--1 Ajay
--9 Haresh
--5 Manish

               CREATE TABLE EMP_DATA (
                  EID INT,
                  NAME VARCHAR(50) );

               INSERT INTO EMP_DATA(EID,NAME) VALUES(1,'AJAY')
               INSERT INTO EMP_DATA(EID,NAME) VALUES(9,'HARESH')
               INSERT INTO EMP_DATA(EID,NAME) VALUES(5,'MANISH')
               SELECT * FROM EMP_DATA

--CUSTOMER
--CID Name
--5 AJAY
--7 MAHESH
--5 MANISH

               CREATE TABLE CUSTOMER (
                  CID INT,
                  NAME VARCHAR(50) );

               INSERT INTO CUSTOMER(CID,NAME) VALUES(5,'AJAY')
               INSERT INTO CUSTOMER(CID,NAME) VALUES(7,'MAHESH')
               INSERT INTO CUSTOMER(CID,NAME) VALUES(5,'MANISH')
               SELECT * FROM CUSTOMER

--1.Display name of persons who is either Employee or Customer.
    SELECT NAME FROM EMP_DATA UNION SELECT NAME FROM CUSTOMER
--2.Display name of persons who is either Employee or Customer including duplicate data.
    SELECT NAME FROM EMP_DATA UNION ALL SELECT NAME FROM CUSTOMER
--3.Display name of persons who is both Employee as well as Customer.
    SELECT NAME FROM EMP_DATA INTERSECT SELECT NAME FROM CUSTOMER
--4.Display name of persons who are Employee but not Customer.
    SELECT NAME FROM EMP_DATA EXCEPT SELECT NAME FROM CUSTOMER
--5.Display name of persons who are Customer but not Employee.
    SELECT NAME FROM CUSTOMER EXCEPT SELECT NAME FROM EMP_DATA

--Part – C:

--1.Perform all the queries of Part-B but display ID and Name columns instead of Name only.
    SELECT EID AS ID, NAME FROM EMP_DATA UNION SELECT CID AS ID, NAME FROM CUSTOMER
    SELECT EID AS ID, NAME FROM EMP_DATA UNION ALL SELECT CID AS ID, NAME FROM CUSTOMER
    SELECT EID AS ID, NAME FROM EMP_DATA INTERSECT SELECT CID AS ID, NAME FROM CUSTOMER
    SELECT EID AS ID, NAME FROM EMP_DATA EXCEPT SELECT CID AS ID, NAME FROM CUSTOMER
    SELECT CID AS ID, NAME FROM CUSTOMER EXCEPT SELECT EID AS ID, NAME FROM EMP_DATA