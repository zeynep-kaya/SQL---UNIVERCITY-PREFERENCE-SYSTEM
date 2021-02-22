--CREATE DATABASE

CREATE DATABASE "db_Assignment3"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'en_US.UTF-8'
       LC_CTYPE = 'en_US.UTF-8'
       CONNECTION LIMIT = -1;

--CREATE TABLE
--4 Table : university, faculty, department, student

Create table tbl_university(
"uniId" serial NOT NULL,
"uniName" varchar(100) NOT NULL,
"uniAddress" varchar(100),
"uniCity" varchar(30) NOT NULL,
"uniType" varchar(30) NOT NULL,
"uniYear" integer NOT NULL,
CONSTRAINT "pk_uni" PRIMARY KEY ("uniId"),
CONSTRAINT "un_university" UNIQUE("uniName")
);

Create table tbl_faculty(
"universityId" int NOT NULL,
"facultyId" serial NOT NULL,
"facultyName" varchar(100) NOT NULL,
CONSTRAINT "pk_faculty" PRIMARY KEY ("facultyId"),
CONSTRAINT "fk_universityId" FOREIGN KEY ("universityId")
REFERENCES tbl_university("uniId") match simple
ON UPDATE CASCADE ON DELETE CASCADE
);

Create table tbl_department(
"facultyId" int NOT NULL,
"deptId" serial NOT NULL,
"deptName" varchar(100) NOT NULL,
"deptLang" varchar(30) NOT NULL,
"deptType" varchar(30) NOT NULL,
"deptQuota" int NOT NULL,
"deptSpecQuota" int NOT NULL,
"deptPeriod" int NOT NULL,
"deptMinScore" int NOT NULL,
"deptMinOrder" int NOT NULL,

CONSTRAINT "pk_dept" PRIMARY KEY ("deptId"),
CONSTRAINT "fk_facultyId" FOREIGN KEY ("facultyId")
REFERENCES tbl_faculty("facultyId") match simple
ON UPDATE CASCADE ON DELETE CASCADE
);

--tbl_student include choices of students
Create table tbl_student(
"studentId" serial NOT NULL,
"studentName" varchar(30),
"studentSurname" varchar(30),
"studentScore" int NOT NULL,
"studentOrder" int NOT NULL,
"choice1" int NOT NULL,
"choice2" int NOT NULL,
"choice3" int NOT NULL,
CONSTRAINT "pk_student" PRIMARY KEY ("studentId")
);

--INSERT OPERATIONS

insert into tbl_university("uniName","uniAddress","uniCity","uniType","uniYear")
values('Dokuz Eylül University','Alsancak','Ýzmir','State',1982),
('Ege University','Bornova','Ýzmir','State',1955),
('Ýzmir Technical University','Urla','Ýzmir','State',1992),
('Ýstanbul Bilgi University','Beyoðlu','Ýstanbul','Private',1996),
('Uludað University','Görükle','Bursa','State',1975),
('Yaþar University','Bayraklý','Ýzmir','Private',2001),
('Ýzmir University','Bostanlý','Ýzmir','Private',2004);

select * from tbl_university

insert into tbl_faculty("universityId","facultyName")
values(1,'Engineering Faculty'),
(1,'Medical Faculty'),
(1,'Law Faculty'),
(2,'Engineering Faculty'),
(2,'Medical Faculty'),
(4,'Engineering Faculty'),
(4,'Law Faculty'),
(5,'Engineering Faculty'),
(5,'Medical Faculty'),
(6,'Engineering Faculty'),
(7,'Engineering Faculty'),
(7,'Medical Faculty'),
(7,'Law Faculty');

select * from tbl_faculty

insert into tbl_department("facultyId","deptName","deptLang","deptType","deptQuota","deptSpecQuota","deptPeriod","deptMinScore","deptMinOrder")
values
(1,'Computer Engineering','English', 'öö' , 75 , 3,4,405000,36000),
(1,'Electrical and Electronics Engineering','English', 'öö' , 60 , 2,4,425000,32000),
(1,'Mechanical Engineering','English', 'iö' , 100 , 3,4,360000,86000),
(2,'Medical','Turkish','öö',80,3,6,485000,6000),
(3, 'Law','Turkish', 'öö',60,2,4,478000,5400),
(4,'Computer Engineering', 'Turkish', 'öö', 90,2,4,418000,33000),
(4,'Chemical Engineering','Turkish', 'iö', 120,4,4,350000,96000),
(5,'Medical','Turkish' ,'öö', 70,2,6,490000,5000),
(6,'Computer Engineering','English', 'öö' , 40 , 1,4,400000,50000),
(6,'Civil Engineering','English','iö',50,1,4,375000,67500),
(7,'Law','Turkish', 'öö',80,1,4,450000,9600),
(8,'Electrical and Electronics Engineering','Turkish','öö',80,2,4,387000,67000),
(8,'Industrial Engineering','Turkish','öö',96,2,4,367500,86700),
(9,'Medical','Turkish','öö',120,3,6,487000,5460),
(10, 'Computer Engineering','English','öö',45,1,4,390540,56000),
(10,'Industrial Engineering','English','öö',56,2,4,387000,74000),
(11,'Mechanical Engineering','English', 'oö' , 38 , 1,4,320000,100000),
(12,'Medical','Turkish','öö',30,1,6,495000,4000),
(13, 'Law','Turkish', 'öö',60,2,4,482000,5000),
(11,'Computer Engineering', 'Turkish', 'iö', 50,2,4,367000,88000);

select * from tbl_department


insert into tbl_student("studentName","studentSurname","studentScore","studentOrder","choice1","choice2","choice3")
values
('Zeynep','Kaya',450000,35000,1,2,3),
('Ece','Ünal',468000,20000,5,4,8),
('Ýlayda', 'Çan',402897,72356,6,3,10),
('Kaan','Bal',435000,45697,12,16,20),
('Onur','Emek',459456,23427,13,15,19),
('Çaðlar','Gürpýnar',500000,100,1,18,3),
('Burcu','Ölmez',250000,200000,10,4,9),
('Nilay', 'Yücel',402897,72356,20,3,10);

select * from tbl_student

---PRINT ALL DEPARTMENTS INFORMATION
SELECT * FROM tbl_university as u INNER JOIN tbl_faculty as f ON u."uniId"= f."universityId" INNER JOIN tbl_department as d ON f."facultyId" = d."facultyId"

--QUESTION 1: Find the university names which are located in the cities whose name starts with “Ý” and founded after 1990.
--This question was answered by using "where" filter

SELECT * FROM tbl_university WHERE SUBSTRING("uniCity",1,1) = 'Ý' and ("uniYear") > 1990



--QUESTION 2: Find the universities which include “Engineering” and “Medicine” Faculties.
--In this question, "intersect" operation was used.

SELECT "uniName" FROM tbl_university AS u 
INNER JOIN tbl_faculty AS f 
ON u."uniId" = f."universityId" 
WHERE f."facultyName" ='Medical Faculty'
INTERSECT
SELECT "uniName" FROM tbl_university as u 
INNER JOIN tbl_faculty AS f 
ON u."uniId" = f."universityId" 
WHERE f."facultyName" = 'Engineering Faculty'



--QUESTION 3: Find the count of faculties according to university types.
--Link established between tables. 
--Faculties, were grouped according to university type.

SELECT "uniType" ,COUNT(f."facultyName") 
FROM tbl_university AS u 
INNER JOIN tbl_faculty AS f 
ON u."uniId"= f."universityId" 
INNER JOIN tbl_department AS d 
ON f."facultyId" = d."facultyId" 
GROUP BY u."uniType" 



--QUESTION 4: Find the departments that contain “engineering” and are the type of “iö”.
--The table was printed the departments according to the "iö" and "engineering" features.

SELECT "uniName" ,"facultyName" , "deptName" ,"deptType" 
FROM tbl_university AS u 
INNER JOIN tbl_faculty AS f 
ON u."uniId"= f."universityId" 
INNER JOIN tbl_department AS d 
ON f."facultyId" = d."facultyId" 
WHERE f."facultyName" = 'Engineering Faculty' AND d."deptType" = 'iö'



--QUESTION 5: Find the top five departments with the longest education period and the highest score.
--"desc" is used in there.
--"limit" is to find the top 5.

SELECT u."uniName",f."facultyName",d."deptName",d."deptPeriod",d."deptMinScore"    
FROM tbl_university AS u 
INNER JOIN tbl_faculty AS f 
ON u."uniId"= f."universityId" 
INNER JOIN tbl_department AS d 
ON f."facultyId" = d."facultyId" 
ORDER BY d."deptPeriod" DESC ,
d."deptMinScore" DESC 
LIMIT 5



--QUESTION 6: Find the most preferred 4-year departments.
--tbl_student and tbl_department are linked with deptId. 
--They were grouped by periods and sorted by "desc".

SELECT d."deptId",d."deptName", d."deptPeriod" ,count(d."deptId") AS count 
FROM tbl_student AS s 
INNER JOIN tbl_department AS d 
INNER JOIN tbl_faculty AS f 
ON d."facultyId" = f."facultyId" 
INNER JOIN tbl_university AS u 
ON u."uniId" = f."universityId" 
ON d."deptId"=s."choice1" OR d."deptId"=s."choice2" OR d."deptId"=s."choice3" 
WHERE d."deptPeriod"= 4 
GROUP BY d."deptId" 
ORDER BY count DESC



--QUESTION 7: List the students who prefer the Department of Computer Engineering as their first choice according to their exam score in a descending order.
--tbl_student and tbl_department are linked with deptId. 
--Those who preferred Computer Engineering were found and ranked according to their score.

SELECT s."studentName",s."studentScore" 
FROM tbl_student AS s 
INNER JOIN tbl_department AS d 
ON d."deptId"=s."choice1" OR d."deptId"=s."choice2" or d."deptId"=s."choice3" 
WHERE 
(d."deptId"=s."choice1" AND d."deptName" = 'Computer Engineering') 
OR (d."deptId"=s."choice2" AND d."deptName" = 'Computer Engineering') 
OR (d."deptId"=s."choice3" AND d."deptName" = 'Computer Engineering')
ORDER BY s."studentScore" DESC



--QUESTION 8: Update the Faculty of Engineering in Dokuz Eylül University to be located in Izmir Technical University.
--Faculty of Engineering in Dokuz Eylül University was found.
--universityId of faculty, was changed.

UPDATE tbl_faculty as f
SET "universityId" = 3 
FROM tbl_university as u
WHERE u."uniId" = f."universityId" and f."facultyName" = 'Engineering Faculty' and u."uniName" = 'Dokuz Eylül University'

--QUESTION 9: Extend the current education period of the departments under the Faculty of Law by one year.

UPDATE tbl_department AS d
SET "deptPeriod"= d."deptPeriod" + 1
FROM tbl_faculty AS f 
WHERE f."facultyId" = d."facultyId" AND f."facultyName" = 'Law Faculty'


--QUESTION 10: Delete the faculties and departments in Ýzmir University.

--for departments of Ýzmir University
DELETE FROM tbl_department 
WHERE "facultyId" 
IN(SELECT "facultyId" FROM tbl_faculty WHERE "universityId" 
	IN (SELECT "uniId" FROM tbl_university WHERE "uniName" = 'Ýzmir University'))  

--for faculties of Ýzmir University
DELETE FROM tbl_faculty 
WHERE "universityId" 
IN (SELECT "uniId" FROM tbl_university WHERE "uniName" = 'Ýzmir University')








