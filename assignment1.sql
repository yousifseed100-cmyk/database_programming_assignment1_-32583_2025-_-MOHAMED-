CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(100) NOT NULL,
    gender VARCHAR2(10),
    department VARCHAR2(50)
);

CREATE TABLE Courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(100) NOT NULL,
    credit_hours NUMBER
);

CREATE TABLE Enrollments (
    enrollment_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    marks NUMBER,
    semester VARCHAR2(20),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES Students(student_id),
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students VALUES (1, 'Ahmed Ali', 'Male', 'CIS');
INSERT INTO Students VALUES (2, 'Aline Uwase', 'Female', 'CIS');
INSERT INTO Students VALUES (3, 'John Bosco', 'Male', 'IT');
INSERT INTO Students VALUES (4, 'Sarah Khan', 'Female', 'IT');
INSERT INTO Students VALUES (5, 'Mohammed Omar', 'Male', 'Networking');

INSERT INTO Courses VALUES (101, 'Database Programming', 3);
INSERT INTO Courses VALUES (102, 'Mobile Communication', 3);
INSERT INTO Courses VALUES (103, 'Computer Networks', 4);
INSERT INTO Courses VALUES (104, 'Web Technology', 3);

INSERT INTO Enrollments VALUES (1, 1, 101, 85, 'Semester 1');
INSERT INTO Enrollments VALUES (2, 1, 102, 78, 'Semester 1');
INSERT INTO Enrollments VALUES (3, 2, 101, 90, 'Semester 1');
INSERT INTO Enrollments VALUES (4, 2, 103, 88, 'Semester 1');
INSERT INTO Enrollments VALUES (5, 3, 101, 65, 'Semester 1');
INSERT INTO Enrollments VALUES (6, 3, 104, 70, 'Semester 1');
INSERT INTO Enrollments VALUES (7, 4, 102, 92, 'Semester 1');
INSERT INTO Enrollments VALUES (8, 4, 103, 81, 'Semester 1');
INSERT INTO Enrollments VALUES (9, 5, 101, 55, 'Semester 1');
INSERT INTO Enrollments VALUES (10, 5, 104, 60, 'Semester 1');

COMMIT;

-- Simple CTE
WITH High_Marks AS (
    SELECT student_id, course_id, marks
    FROM Enrollments
    WHERE marks >= 80
)
SELECT *
FROM High_Marks;

-- Multiple CTEs
WITH Passed_Students AS (
    SELECT student_id, marks
    FROM Enrollments
    WHERE marks >= 50
),
Student_Averages AS (
    SELECT student_id, AVG(marks) AS average_marks
    FROM Passed_Students
    GROUP BY student_id
)
SELECT *
FROM Student_Averages;

-- Recursive example in Oracle 11g
SELECT LEVEL AS level_no
FROM dual
CONNECT BY LEVEL <= 5;

-- CTE with Aggregation
WITH Course_Average AS (
    SELECT 
        course_id,
        AVG(marks) AS average_marks,
        MIN(marks) AS lowest_mark,
        MAX(marks) AS highest_mark
    FROM Enrollments
    GROUP BY course_id
)
SELECT *
FROM Course_Average;

-- CTE with JOIN
WITH Student_Course_Marks AS (
    SELECT 
        s.student_name,
        c.course_name,
        e.marks
    FROM Enrollments e
    JOIN Students s ON e.student_id = s.student_id
    JOIN Courses c ON e.course_id = c.course_id
)
SELECT *
FROM Student_Course_Marks;

-- ROW_NUMBER()
SELECT
    student_id,
    course_id,
    marks,
    ROW_NUMBER() OVER (ORDER BY marks DESC) AS row_num
FROM Enrollments;

-- RANK()
SELECT
    student_id,
    course_id,
    marks,
    RANK() OVER (ORDER BY marks DESC) AS student_rank
FROM Enrollments;

-- DENSE_RANK()
SELECT
    student_id,
    course_id,
    marks,
    DENSE_RANK() OVER (ORDER BY marks DESC) AS dense_rank
FROM Enrollments;

-- PERCENT_RANK()
SELECT
    student_id,
    course_id,
    marks,
    PERCENT_RANK() OVER (ORDER BY marks DESC) AS percent_rank
FROM Enrollments;

-- SUM() OVER()
SELECT
    student_id,
    course_id,
    marks,
    SUM(marks) OVER (ORDER BY student_id) AS running_total
FROM Enrollments;

-- AVG() OVER()
SELECT
    student_id,
    course_id,
    marks,
    AVG(marks) OVER () AS overall_average
FROM Enrollments;

-- MIN() OVER()
SELECT
    student_id,
    course_id,
    marks,
    MIN(marks) OVER () AS minimum_mark
FROM Enrollments;

-- MAX() OVER()
SELECT
    student_id,
    course_id,
    marks,
    MAX(marks) OVER () AS maximum_mark
FROM Enrollments;

-- LAG()
SELECT
    student_id,
    course_id,
    marks,
    LAG(marks) OVER (ORDER BY marks DESC) AS previous_mark
FROM Enrollments;

-- LEAD()
SELECT
    student_id,
    course_id,
    marks,
    LEAD(marks) OVER (ORDER BY marks DESC) AS next_mark
FROM Enrollments;

-- NTILE()
SELECT
    student_id,
    course_id,
    marks,
    NTILE(4) OVER (ORDER BY marks DESC) AS quartile
FROM Enrollments;

-- CUME_DIST()
SELECT
    student_id,
    course_id,
    marks,
    CUME_DIST() OVER (ORDER BY marks DESC) AS cumulative_distribution
FROM Enrollments;