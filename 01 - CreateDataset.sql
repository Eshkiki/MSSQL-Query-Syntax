/* ========== Clean slate (safe for re-runs in a dev DB) ========== */
IF OBJECT_ID('dbo.courseStudent','U') IS NOT NULL DROP TABLE dbo.courseStudent;
IF OBJECT_ID('dbo.courseApplicant','U') IS NOT NULL DROP TABLE dbo.courseApplicant;
IF OBJECT_ID('dbo.course','U') IS NOT NULL DROP TABLE dbo.course;
IF OBJECT_ID('dbo.teacher','U') IS NOT NULL DROP TABLE dbo.teacher;
IF OBJECT_ID('dbo.student','U') IS NOT NULL DROP TABLE dbo.student;
IF OBJECT_ID('dbo.city','U') IS NOT NULL DROP TABLE dbo.city;
GO

/* ========== Core tables (camelCase) ========== */

-- Cities (self-referencing hierarchy)
CREATE TABLE dbo.city
(
    cityCode   VARCHAR(10)    NOT NULL PRIMARY KEY,
    cityName   NVARCHAR(100)  NOT NULL,
    region     NVARCHAR(100)  NULL,
    parentCode VARCHAR(10)    NULL,
    CONSTRAINT FK_city_parent
        FOREIGN KEY (parentCode) REFERENCES dbo.city(cityCode)
);
GO

-- Students
CREATE TABLE dbo.student
(
    studentId  INT            NOT NULL PRIMARY KEY,
    firstName  NVARCHAR(50)   NULL,
    lastName   NVARCHAR(50)   NULL,
    birthYear  SMALLINT       NULL,   -- 1995..2010 per your dataset
    education  NVARCHAR(50)   NULL,
    gender     SMALLINT       NULL,   -- 0=female,1=male,2=other (example)
    regDate    VARCHAR(10)    NULL,   -- demo 'YYYY/MM/DD'
    cityCode   VARCHAR(10)    NULL,
    telephone  VARCHAR(20)    NULL,
    address    NVARCHAR(200)  NULL,
    CONSTRAINT CK_student_birthYear CHECK (birthYear BETWEEN 1900 AND 2100),
    CONSTRAINT FK_student_city FOREIGN KEY (cityCode) REFERENCES dbo.city(cityCode)
);
GO

-- Teachers
CREATE TABLE dbo.teacher
(
    teacherId INT IDENTITY(1,1) PRIMARY KEY,
    firstName NVARCHAR(50)   NOT NULL,
    lastName  NVARCHAR(50)   NOT NULL,
    hireDate  DATE           NULL,
    subject   NVARCHAR(100)  NULL,
    email     NVARCHAR(100)  NULL,
    phone     VARCHAR(20)    NULL,
    address   NVARCHAR(200)  NULL
);
GO
CREATE INDEX IX_teacher_subject ON dbo.teacher(subject);
GO

-- Courses (each course owned by a primary teacher)
CREATE TABLE dbo.course
(
    courseId     VARCHAR(10)    NOT NULL PRIMARY KEY,
    standardCode VARCHAR(20)    NULL,   -- optional curriculum code (metadata)
    description  NVARCHAR(200)  NULL,
    teacherId    INT            NOT NULL,
    CONSTRAINT FK_course_teacher FOREIGN KEY (teacherId) REFERENCES dbo.teacher(teacherId)
);
GO
CREATE INDEX IX_course_teacher      ON dbo.course(teacherId);
CREATE INDEX IX_course_standardCode ON dbo.course(standardCode);
GO

-- Enrolments: student ↔ course + the teacher who delivered the instance
CREATE TABLE dbo.courseStudent
(
    courseId    VARCHAR(10)   NOT NULL,
    studentId   INT           NOT NULL,
    teacherId   INT           NOT NULL,     -- teacher for this instance
    enrollDate  DATE          NULL,
    grade       DECIMAL(5,2)  NULL,
    debt        DECIMAL(10,2) NOT NULL CONSTRAINT DF_courseStudent_debt DEFAULT (0),

    CONSTRAINT PK_courseStudent PRIMARY KEY (courseId, studentId),
    CONSTRAINT FK_courseStudent_course  FOREIGN KEY (courseId)  REFERENCES dbo.course(courseId),
    CONSTRAINT FK_courseStudent_student FOREIGN KEY (studentId) REFERENCES dbo.student(studentId),
    CONSTRAINT FK_courseStudent_teacher FOREIGN KEY (teacherId) REFERENCES dbo.teacher(teacherId)
);
GO
CREATE INDEX IX_courseStudent_student ON dbo.courseStudent(studentId);
CREATE INDEX IX_courseStudent_course  ON dbo.courseStudent(courseId);
CREATE INDEX IX_courseStudent_teacher ON dbo.courseStudent(teacherId);
GO

-- Applicants (now tied to an actual course)
CREATE TABLE dbo.courseApplicant
(
    applicantId INT           NOT NULL PRIMARY KEY,
    firstName   NVARCHAR(50)  NULL,
    lastName    NVARCHAR(50)  NULL,
    courseId    VARCHAR(10)   NOT NULL,
    applyDate   DATE          NULL,
    status      NVARCHAR(20)  NULL,
    CONSTRAINT FK_courseApplicant_course FOREIGN KEY (courseId) REFERENCES dbo.course(courseId)
);
GO
CREATE INDEX IX_courseApplicant_course ON dbo.courseApplicant(courseId);
GO

/* ========== Sample data (camelCase) ========== */

-- city
INSERT INTO dbo.city (cityCode, cityName, region, parentCode) VALUES
 ('020', N'London',       N'England',  NULL),
 ('021', N'Westminster',  N'England',  '020'),
 ('011', N'Bristol',      N'England',  NULL),
 ('012', N'Manchester',   N'England',  NULL),
 ('013', N'Cardiff',      N'Wales',    NULL),
 ('014', N'Cambridge',    N'England',  NULL),
 ('015', N'Edinburgh',    N'Scotland', NULL);

-- teacher
INSERT INTO dbo.teacher (firstName, lastName, hireDate, subject, email, phone, address) VALUES
 (N'William',  N'Harris',  '2012-09-01', N'Database Systems', 'wharris@example.com',  '07711111111', N'London, King’s Cross'),
 (N'Elizabeth',N'Martin',  '2015-01-15', N'SQL Programming',  'emartin@example.com',  '07722222222', N'Bristol, Park Street'),
 (N'Thomas',   N'Wright',  '2018-04-20', N'Algorithms',       'twright@example.com',  '07733333333', N'Manchester, Deansgate'),
 (N'Charlotte',N'Hall',    '2016-06-10', N'Web Development',  'chall@example.com',    '07744444444', N'Cardiff, City Road'),
 (N'Henry',    N'Green',   '2010-02-01', N'Computer Science', 'hgreen@example.com',   '07755555555', N'Cambridge, Trinity Street');
GO

-- student
INSERT INTO dbo.student (studentId, firstName, lastName, birthYear, education, gender, regDate, cityCode, telephone, address) VALUES
 (1, N'James',   N'Smith',   1998, N'Bachelor',   1, '2015/09/01', '020', '07111111111', N'London, Baker Street'),
 (2, N'Emily',   N'Johnson', 2000, N'Master',     0, '2017/03/15', '011', '07222222222', N'Bristol, Clifton'),
 (3, N'Daniel',  N'Brown',   1997, N'Diploma',    1, '2016/11/20', '012', '07333333333', N'Manchester, Oxford Road'),
 (4, N'Sophie',  N'Wilson',  2002, N'Bachelor',   0, '2019/10/10', '013', '07444444444', N'Cardiff, Queen Street'),
 (5, N'Oliver',  N'Taylor',  1995, N'PhD',        1, '2014/05/22', '014', '07555555555', N'Cambridge, King’s Parade'),
 (6, N'Grace',   N'Evans',   2010, N'HighSchool', 0, '2024/01/12', '015', '07666666666', N'Edinburgh, Princes Street');
GO

-- course  (teacherId values correspond to insert order above: 1..5)
INSERT INTO dbo.course (courseId, standardCode, description, teacherId) VALUES
 ('C101', '13960101', N'Database Fundamentals',        1), -- William Harris
 ('C102', '13960102', N'SQL Programming',              2), -- Elizabeth Martin
 ('C103', '13960103', N'Algorithms & Data Structures', 3), -- Thomas Wright
 ('C104', '13960104', N'Web Development Basics',       4); -- Charlotte Hall
GO

-- courseStudent
INSERT INTO dbo.courseStudent (courseId, studentId, teacherId, enrollDate, grade, debt) VALUES
 ('C101', 1, 1, '2015-09-10', 18.50,  0.00),
 ('C101', 2, 1, '2017-03-20', 16.00,  0.00),
 ('C101', 3, 1, '2016-11-25', 12.00, 50.00),
 ('C102', 1, 2, '2016-01-15', 15.75,  0.00),
 ('C102', 4, 2, '2019-10-20',  NULL, 200.00),  -- not graded yet
 ('C103', 5, 3, '2014-06-01', 19.25,  0.00),
 ('C103', 6, 3, '2024-02-01', 13.00,  0.00),
 ('C104', 2, 4, '2018-09-01', 14.50,100.00),
 ('C104', 3, 4, '2019-01-05',  NULL,  0.00),
 ('C104', 4, 4, '2020-01-10', 17.75,  0.00);
GO

-- courseApplicant
INSERT INTO dbo.courseApplicant (applicantId, firstName, lastName, courseId, applyDate, status) VALUES
 (101, N'James',     N'Smith',   'C101', '2024-08-01', N'Pending'),
 (102, N'Emily',     N'Johnson', 'C102', '2024-08-05', N'Accepted'),
 (103, N'George',    N'Clark',   'C103', '2024-08-10', N'Pending'),
 (104, N'Charlotte', N'Lewis',   'C104', '2024-08-12', N'Rejected'),
 (105, N'Matthew',   N'Walker',  'C101', '2024-08-15', N'Pending'),
 (106, N'Sophie',    N'Wilson',  'C102', '2024-08-18', N'Accepted');
GO
