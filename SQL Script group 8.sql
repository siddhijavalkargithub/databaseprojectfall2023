CREATE DATABASE AttendanceManagementSystem;
-- DROP DATABASE AttendanceManagementSystem;
use AttendanceManagementSystem;
-- SHOW TABLES;
-- Table structure for `university`
-- DROP TABLE IF EXISTS `university`;
CREATE TABLE AttendanceManagementSystem.university(
university_id INT NOT NULL AUTO_INCREMENT,
university_name VARCHAR(70) NOT NULL,
university_code VARCHAR(45) NOT NULL,
PRIMARY KEY(university_id));
-- Inserting into university using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.university;
INSERT INTO AttendanceManagementSystem.university (university_id , university_name, university_code) 
VALUES ('2401', 'The University of Texas at Dallas', 'UTD');
INSERT INTO AttendanceManagementSystem.university (university_id , university_name, university_code) 
VALUES ('2402', 'The University of Texas at Austin', 'UTA');
INSERT INTO AttendanceManagementSystem.university (university_id , university_name, university_code) 
VALUES ('2403', 'The University of Texas at Arlington', 'UTR');
-- Table structure for `school`
-- DROP TABLE IF EXISTS `school`;
CREATE TABLE AttendanceManagementSystem.school(
school_id VARCHAR(30) NOT NULL,
school_name VARCHAR(70) NOT NULL,
school_code VARCHAR(45) NOT NULL,
university_id INT NOT NULL,
PRIMARY KEY (school_id),
-- FOREIGN KEY for school TABLE
INDEX university_idx (university_id ASC) VISIBLE,
  CONSTRAINT university_id
    FOREIGN KEY (university_id)
    REFERENCES AttendanceManagementSystem.university (university_id)
    -- ON DELETE SET DEFAULT 1234
    ON UPDATE CASCADE);
-- Inserting into school using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.school;
INSERT INTO AttendanceManagementSystem.school (school_id , school_name, school_code, university_id) 
VALUES ('3651', 'Naveen Jindal School of Management', 'JSOM','2401');
INSERT INTO AttendanceManagementSystem.school(school_id , school_name, school_code, university_id) 
VALUES ('4571', 'Eric Johnson School of Engineering ', 'ECS','2401');
-- Table structure for `department`
-- DROP TABLE IF EXISTS `department`;
CREATE TABLE AttendanceManagementSystem.department(
department_id VARCHAR(30) NOT NULL,
department_name VARCHAR(70) NOT NULL,
department_code VARCHAR(45) NOT NULL,
school_id VARCHAR(30) NOT NULL,
PRIMARY KEY (department_id),
-- FOREIGN KEY for DEPARTMENT TABLE
INDEX school_idx (school_id ASC) VISIBLE,
  CONSTRAINT school_id
    FOREIGN KEY (school_id)
    REFERENCES AttendanceManagementSystem.school (school_id)
    -- ON DELETE SET DEFAULT 1234
    ON UPDATE CASCADE);
-- Inserting into department using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.department;
INSERT INTO AttendanceManagementSystem.department(department_id , department_name, department_code, school_id) 
VALUES ('1251',	'Business Analytics', 'BUAN', '3651');
-- Table structure for `professor`
-- DROP TABLE IF EXISTS `professor`;
CREATE TABLE AttendanceManagementSystem.professor(
professor_id INT NOT NULL AUTO_INCREMENT,
net_id VARCHAR(45) NOT NULL,
professor_firstname VARCHAR(70) NOT NULL,
professor_lastname VARCHAR(70) NOT NULL,
PRIMARY KEY (professor_id));
INSERT INTO AttendanceManagementSystem.professor(professor_id,net_id,professor_firstname,professor_lastname)
VALUES ('15285748',	'KDP730374','Fayth','Caldero');
-- Inserting into professor using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.professor;
-- Table structure for `student`
-- DROP TABLE IF EXISTS `student`;
CREATE TABLE AttendanceManagementSystem.student(
student_id INT NOT NULL AUTO_INCREMENT,
net_id VARCHAR(45) NOT NULL,
student_firstname VARCHAR(70) NOT NULL,
student_lastname VARCHAR(70) NOT NULL,
PRIMARY KEY (student_id));
INSERT INTO AttendanceManagementSystem.student(student_id,net_id,student_firstname,student_lastname)
VALUES ('14708852',	'AVR224375','Carson','Betton');
-- Inserting into student using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.student;
-- Table structure for `course`
-- DROP TABLE IF EXISTS `course`;
CREATE TABLE AttendanceManagementSystem.course(
course_id VARCHAR(30) NOT NULL,
course_title VARCHAR(45) NOT NULL,
course_code VARCHAR(45) NOT NULL,
course_section VARCHAR(45) NOT NULL,
course_day VARCHAR(45) NOT NULL,
course_time VARCHAR(30) NOT NULL,
professor_id INT NOT NULL,
department_id VARCHAR(30) NOT NULL,
PRIMARY KEY (course_id),
-- FOREIGN KEY for COURSE TABLE
    INDEX professor_idx (professor_id ASC) VISIBLE,
    CONSTRAINT fk4_professor_id
        FOREIGN KEY (professor_id)
        REFERENCES AttendanceManagementSystem.professor (professor_id)
        ON UPDATE CASCADE,
	INDEX department_idx (department_id ASC) VISIBLE,
    CONSTRAINT fk4_department_id
        FOREIGN KEY (department_id)
        REFERENCES AttendanceManagementSystem.department (department_id)
        ON UPDATE CASCADE
        );
INSERT INTO AttendanceManagementSystem.course(course_id,course_title,course_code,course_section,course_day,course_time,professor_id,department_id)
VALUES ('FIN6368.0001',	'Financial Information and Analysis','FIN6368','0001','Tuesday','4pm-7:45pm','15285748','1251');
-- Inserting into course using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.course;
-- Table structure for `leave_type`
-- DROP TABLE IF EXISTS `leave_type`;
CREATE TABLE AttendanceManagementSystem.leave_type(
leave_id INT NOT NULL AUTO_INCREMENT,
leave_type VARCHAR(45) NOT NULL,
PRIMARY KEY (leave_id));
INSERT INTO AttendanceManagementSystem.leave_type(leave_id,leave_type)
VALUES ('1','holiday');
-- Inserting into leave_type using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.leave_type;
-- Table structure for `holiday`
-- DROP TABLE IF EXISTS `holiday`;
CREATE TABLE AttendanceManagementSystem.holiday(
    holiday_id VARCHAR(30) NOT NULL,
    holiday_name VARCHAR(70) NOT NULL,
    holiday_date DATE NOT NULL,
    leave_id INT NOT NULL,
    PRIMARY KEY (holiday_id,holiday_date),
    -- FOREIGN KEY for HOLIDAY TABLE
    INDEX leave_idx (leave_id ASC) VISIBLE,
    CONSTRAINT leave_id
        FOREIGN KEY (leave_id)
        REFERENCES AttendanceManagementSystem.leave_type (leave_id)
        ON UPDATE CASCADE
);
INSERT INTO AttendanceManagementSystem.holiday (holiday_id,holiday_name,holiday_date,leave_id)
VALUES ('hol_17','Spring break','2024-03-17','1');
-- Inserting into holiday using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.holiday;
-- Table structure for `allowed_leaves`
-- DROP TABLE IF EXISTS `allowed_leaves`;

CREATE TABLE AttendanceManagementSystem.allowed_leaves(
	allowed_leaves_id INT NOT NULL, 
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    number_of_leaves INT NOT NULL,
    course_id VARCHAR(30) NOT NULL,
    professor_id INT NOT NULL,
    department_id VARCHAR(30) NOT NULL,
    leave_id INT NOT NULL,
    PRIMARY KEY (allowed_leaves_id),
    -- FOREIGN KEY for ALLOWED_LEAVES TABLE
    INDEX course_idx (course_id ASC) VISIBLE,
    CONSTRAINT fk_course_id
        FOREIGN KEY (course_id)
        REFERENCES AttendanceManagementSystem.course (course_id)
        ON UPDATE CASCADE,
    INDEX professor_idx (professor_id ASC) VISIBLE,
    CONSTRAINT fk_professor_id
        FOREIGN KEY (professor_id)
        REFERENCES AttendanceManagementSystem.professor (professor_id)
        ON UPDATE CASCADE,
    INDEX department_idx (department_id ASC) VISIBLE,
    CONSTRAINT fk_department_id
        FOREIGN KEY (department_id)
        REFERENCES AttendanceManagementSystem.department (department_id)
        ON UPDATE CASCADE,
    INDEX leave_idx (leave_id ASC) VISIBLE,
    CONSTRAINT fk_leave_id
        FOREIGN KEY (leave_id)
        REFERENCES AttendanceManagementSystem.leave_type (leave_id)
        ON UPDATE CASCADE
);
INSERT INTO AttendanceManagementSystem.allowed_leaves (start_date,end_date,number_of_leaves,course_id,professor_id,department_id,leave_id)
VALUES ('2023-08-21','2024-01-15','2','FIN6368.0001','15285748','1251','1');
-- Inserting into allowed_leaves using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.allowed_leaves;
-- Table structure for `test_days`
-- DROP TABLE IF EXISTS `test_days`;

CREATE TABLE AttendanceManagementSystem.test_days(
test_days_id INT NOT NULL,
test_start_date DATE NOT NULL,
test_end_date DATE NOT NULL,
course_id VARCHAR(30) NOT NULL,
professor_id INT NOT NULL,
department_id VARCHAR(30) NOT NULL,
leave_id INT NOT NULL,
PRIMARY KEY(test_days_id),
-- FOREIGN KEY for TEST_DAYS TABLE
INDEX course_idx (course_id ASC) VISIBLE,
  CONSTRAINT fk1_course_id
    FOREIGN KEY (course_id)
    REFERENCES AttendanceManagementSystem.course (course_id)
    ON UPDATE CASCADE,
    INDEX professor_idx (professor_id ASC) VISIBLE,
  CONSTRAINT fk1_professor_id
    FOREIGN KEY (professor_id)
    REFERENCES AttendanceManagementSystem.professor (professor_id)
    ON UPDATE CASCADE,
    INDEX department_idx (department_id ASC) VISIBLE,
  CONSTRAINT fk1_department_id
    FOREIGN KEY (department_id)
    REFERENCES AttendanceManagementSystem.department (department_id)
    ON UPDATE CASCADE,
    INDEX leave_idx (leave_id ASC) VISIBLE,
  CONSTRAINT fk1_leave_id
    FOREIGN KEY (leave_id)
    REFERENCES AttendanceManagementSystem.leave_type (leave_id)
    ON UPDATE CASCADE);
INSERT INTO AttendanceManagementSystem.test_days (test_start_date,test_end_date,course_id,professor_id,department_id,leave_id)
VALUES ('2023-10-03','2023-10-04','FIN6368.0001','15285748','1251','1');
-- Inserting into test_days using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.test_days;
-- Table structure for `student_course`
-- DROP TABLE IF EXISTS `student_course`;

CREATE TABLE AttendanceManagementSystem.student_course(
student_course_id INT NOT NULL,
course_id VARCHAR(30) NOT NULL,
professor_id INT NOT NULL,
class_date DATE NOT NULL,
attendance_status ENUM('Y','N'),
leave_id INT NOT NULL,
student_id INT NOT NULL,
PRIMARY KEY(student_course_id),
-- FOREIGN KEY for STUDENT_COURSE TABLE
INDEX course_idx (course_id ASC) VISIBLE,
  CONSTRAINT fk2_course_id
    FOREIGN KEY (course_id)
    REFERENCES AttendanceManagementSystem.course (course_id)
    ON UPDATE CASCADE,
    INDEX professor_idx (professor_id ASC) VISIBLE,
  CONSTRAINT fk2_professor_id
    FOREIGN KEY (professor_id)
    REFERENCES AttendanceManagementSystem.professor (professor_id)
    ON UPDATE CASCADE,
    INDEX student_idx (student_id ASC) VISIBLE,
  CONSTRAINT fk2_student_id
    FOREIGN KEY (student_id)
    REFERENCES AttendanceManagementSystem.student (student_id)
    ON UPDATE CASCADE,
    INDEX leave_idx (leave_id ASC) VISIBLE,
  CONSTRAINT fk2_leave_id
    FOREIGN KEY (leave_id)
    REFERENCES AttendanceManagementSystem.leave_type (leave_id)
    ON UPDATE CASCADE);
INSERT INTO AttendanceManagementSystem.student_course (course_id,professor_id,attendance_status,leave_id,student_id)
VALUES ('FIN6368.0001','15285748','Y','1','14708852');
-- Inserting into student_course using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.student_course;
-- Table structure for `course_holiday`
-- DROP TABLE IF EXISTS `course_holiday`;

CREATE TABLE AttendanceManagementSystem.course_holiday(
course_holiday_id int NOT NULL,
course_id VARCHAR(30) NOT NULL,
professor_id INT NOT NULL,
department_id VARCHAR(30) NOT NULL,
holiday_id VARCHAR(30) NOT NULL,
holiday_date DATE NOT NULL,
leave_id INT NOT NULL,
PRIMARY KEY(course_holiday_id),
-- FOREIGN KEY for STUDENT_COURSE TABLE
INDEX course_idx (course_id ASC) VISIBLE,
  CONSTRAINT fk3_course_id
    FOREIGN KEY (course_id)
    REFERENCES AttendanceManagementSystem.course (course_id)
    ON UPDATE CASCADE,
    INDEX professor_idx (professor_id ASC) VISIBLE,
  CONSTRAINT fk3_professor_id
    FOREIGN KEY (professor_id)
    REFERENCES AttendanceManagementSystem.professor (professor_id)
    ON UPDATE CASCADE,
    INDEX department_idx (department_id ASC) VISIBLE,
  CONSTRAINT fk3_department_id
    FOREIGN KEY (department_id)
    REFERENCES AttendanceManagementSystem.department (department_id)
    ON UPDATE CASCADE,
    INDEX holiday_idx (holiday_id ASC) VISIBLE,
  CONSTRAINT fk3_holiday_id
    FOREIGN KEY (holiday_id,holiday_date)
    REFERENCES AttendanceManagementSystem.holiday (holiday_id,holiday_date)
    ON UPDATE CASCADE,
    INDEX leave_idx (leave_id ASC) VISIBLE,
  CONSTRAINT fk3_leave_id
    FOREIGN KEY (leave_id)
    REFERENCES AttendanceManagementSystem.leave_type (leave_id)
    ON UPDATE CASCADE
    );
INSERT INTO AttendanceManagementSystem.course_holiday (course_id,professor_id,department_id,holiday_id,holiday_date,leave_id)
VALUES ('FIN6368.0001','15285748','1251','hol_17','2024-03-17','1');
-- Inserting into course_holiday using table import data wizard
-- SELECT * FROM AttendanceManagementSystem.course_holiday;

select*from student_course;

#Query1 : Retrieve the count of allowed leaves for each course:
SELECT c.course_id,COUNT(al.allowed_leaves_id) AS allowed_leaves_count
FROM AttendanceManagementSystem.course c
LEFT JOIN AttendanceManagementSystem.allowed_leaves al ON c.course_id = al.course_id
GROUP BY c.course_id;


#Query2:Retrieve a list of students with their attendance percentage for all courses
SELECT s.student_id,s.net_id,s.student_firstname,s.student_lastname,c.course_id,
(COUNT(sc.student_course_id) / (SELECT COUNT(*) FROM AttendanceManagementSystem.course WHERE professor_id = '15285748')) * 100 AS attendance_percentage
FROM AttendanceManagementSystem.student_course sc
JOIN AttendanceManagementSystem.student s ON sc.student_id = s.student_id
JOIN AttendanceManagementSystem.course c ON sc.course_id = c.course_id
WHERE sc.attendance_status = 'Y'
GROUP BY s.student_id, c.course_id;

#Query3: Find the courses with the highest average attendance percentage:
SELECT c.course_id,c.course_title,AVG(CASE WHEN sc.attendance_status = 'Y' THEN 1 ELSE 0 END) * 100 AS average_attendance_percentage
FROM AttendanceManagementSystem.course c
LEFT JOIN AttendanceManagementSystem.student_course sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_title
ORDER BY average_attendance_percentage DESC;

#Query4:Calculate the percentage of students who attended each class for a specific course
SELECT c.course_id,c.course_title,sc.class_date,
    (COUNT(sc.student_id) / (SELECT COUNT(*) FROM AttendanceManagementSystem.student WHERE student_id IN (SELECT student_id FROM AttendanceManagementSystem.student_course WHERE course_id = c.course_id))) * 100 AS attendance_percentage
FROM AttendanceManagementSystem.course c
LEFT JOIN AttendanceManagementSystem.student_course sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_title, sc.class_date
ORDER BY c.course_id, sc.class_date;

#Query5:Retrieve Leaves and holidays of a particular student('27059590' ) in all their courses

SELECT student_id,course_id,attendance_status, COUNT(*) AS absent_days 
FROM student_course 
WHERE attendance_status = 'N' and student_id = '27059590' AND leave_id IN (1,2)
GROUP BY student_id,course_id;


#Query6:Attendance in a particular month (21 Aug 2021 -21 Sept 2023) for department 1377.

SELECT d.department_id, d.department_code, sc.student_id, c.course_id, sc.attendance_status 
FROM student_course sc INNER JOIN course c ON sc.course_id = c.course_id
INNER JOIN department d ON c.department_id = d.department_id
WHERE d.department_id = 1377 AND sc.class_date BETWEEN '2023-08-21' AND '2023-09-21';


#Query7:Number of actual leaves (other than test days, allowed leaves, holidays) for student in BUAN6320.0001
SELECT student_id,course_id, COUNT(*) AS actual_leaves
FROM student_course
WHERE course_id = 'BUAN6320.0001' AND    
attendance_status = 'N' AND leave_id NOT IN (
SELECT test_days_id FROM test_days WHERE course_id = 'BUAN6320.0001' UNION 
SELECT allowed_leaves_id FROM allowed_leaves WHERE course_id = 'BUAN6320.0001' UNION 
SELECT holiday_id FROM holiday)
group by student_id;

#Query8:Retrieve the average attendance for each student in each course within department 1251 during a specified date range ('2023-08-21' to '2023-12-15').

SELECT sc.course_id, s.student_id, AVG(CASE WHEN sc.attendance_status = 'Y' THEN 1 ELSE 0 END) AS average_attendance 
	FROM student s INNER JOIN student_course sc ON s.student_id = sc.student_id 
	inner join course c on sc.course_id = c.course_id 
	WHERE c.department_id = 1251 AND sc.class_date BETWEEN '2023-08-21' AND '2023-12-15' 
	GROUP BY sc.course_id,s.student_id;


