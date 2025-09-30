/* ========== Clean slate (safe for re-runs in a dev DB) ========== */
IF OBJECT_ID('dbo.TCourse_Student','U') IS NOT NULL DROP TABLE dbo.TCourse_Student;
IF OBJECT_ID('dbo.TCourse_Applicant','U') IS NOT NULL DROP TABLE dbo.TCourse_Applicant;
IF OBJECT_ID('dbo.TCourses','U') IS NOT NULL DROP TABLE dbo.TCourses;
IF OBJECT_ID('dbo.TTeacher','U') IS NOT NULL DROP TABLE dbo.TTeacher;
IF OBJECT_ID('dbo.TStudent','U') IS NOT NULL DROP TABLE dbo.TStudent;
IF OBJECT_ID('dbo.TCity','U') IS NOT NULL DROP TABLE dbo.TCity;
GO

/* ========== Core tables ========== */

-- Students
CREATE TABLE dbo.TStudent
(
    Code_St      INT            NOT NULL PRIMARY KEY,
    FName        NVARCHAR(50)   NULL,
    LName        NVARCHAR(50)   NULL,
    BDate        SMALLINT       NULL,           -- 1995..2010 per your dataset
    Education    NVARCHAR(50)   NULL,
    Gender       SMALLINT       NULL,           -- 0=female,1=male,2=other (example)
    D_Reg        VARCHAR(10)    NULL,           -- demo 'YYYY/MM/DD'
    CityCode     VARCHAR(10)    NULL,
    Telephone    VARCHAR(20)    NULL,
    Address      NVARCHAR(200)  NULL,
    CONSTRAINT CK_TStudent_BDate CHECK (BDate BETWEEN 1900 AND 2100)
);
GO

-- Teachers
CREATE TABLE dbo.TTeacher
(
    Code_Teacher   INT IDENTITY(1,1) PRIMARY KEY,
    FName          NVARCHAR(50)   NOT NULL,
    LName          NVARCHAR(50)   NOT NULL,
    HireDate       DATE           NULL,
    [Subject]      NVARCHAR(100)  NULL,
    Email          NVARCHAR(100)  NULL,
    Phone          VARCHAR(20)    NULL,
    Address        NVARCHAR(200)  NULL
);
GO
CREATE INDEX IX_TTeacher_Subject ON dbo.TTeacher([Subject]);
GO

-- Courses (each course owned by a primary teacher)
CREATE TABLE dbo.TCourses
(
    Code_Course    VARCHAR(10)    NOT NULL PRIMARY KEY,
    Code_Standard  VARCHAR(20)    NULL,             -- optional curriculum code (kept as metadata)
    Descriptions   NVARCHAR(200)  NULL,
    Code_Teacher   INT            NOT NULL,           -- FK -> TTeacher
    CONSTRAINT FK_TCourses_Teacher 
        FOREIGN KEY (Code_Teacher) REFERENCES dbo.TTeacher(Code_Teacher)
);
GO
CREATE INDEX IX_TCourses_Teacher ON dbo.TCourses(Code_Teacher);
CREATE INDEX IX_TCourses_CodeStandard ON dbo.TCourses(Code_Standard);
GO

-- Enrolments (student↔course) + the teacher who delivered the instance
CREATE TABLE dbo.TCourse_Student
(
    Code_Course   VARCHAR(10)   NOT NULL,
    Code_St       INT           NOT NULL,
    Code_Teacher  INT           NOT NULL,           -- << added and connected to TTeacher
    EnrollDate    DATE          NULL,
    Grade         DECIMAL(5,2)  NULL,
    Debt          DECIMAL(10,2) NOT NULL CONSTRAINT DF_TCourse_Student_Debt DEFAULT (0),

    CONSTRAINT PK_TCourse_Student PRIMARY KEY (Code_Course, Code_St),
    CONSTRAINT FK_TCourse_Student_Course   FOREIGN KEY (Code_Course)  REFERENCES dbo.TCourses(Code_Course),
    CONSTRAINT FK_TCourse_Student_Student  FOREIGN KEY (Code_St)      REFERENCES dbo.TStudent(Code_St),
    CONSTRAINT FK_TCourse_Student_Teacher  FOREIGN KEY (Code_Teacher) REFERENCES dbo.TTeacher(Code_Teacher)
);
GO
CREATE INDEX IX_TCourse_Student_St      ON dbo.TCourse_Student(Code_St);
CREATE INDEX IX_TCourse_Student_Course  ON dbo.TCourse_Student(Code_Course);
CREATE INDEX IX_TCourse_Student_Teacher ON dbo.TCourse_Student(Code_Teacher);
GO

-- Applicants (now tied to an actual course, not just a code_standard)
CREATE TABLE dbo.TCourse_Applicant
(
    Applicant_Id   INT            NOT NULL PRIMARY KEY,
    FName          NVARCHAR(50)   NULL,
    LName          NVARCHAR(50)   NULL,
    Code_Course    VARCHAR(10)    NOT NULL,          -- << changed, FK -> TCourses
    ApplyDate      DATE           NULL,
    Status         NVARCHAR(20)   NULL,
    CONSTRAINT FK_TCourse_Applicant_Course
        FOREIGN KEY (Code_Course) REFERENCES dbo.TCourses(Code_Course)
);
GO
CREATE INDEX IX_TCourse_Applicant_Course ON dbo.TCourse_Applicant(Code_Course);
GO

-- City Table 
CREATE TABLE dbo.TCity
(
    CityCode    VARCHAR(10)   NOT NULL PRIMARY KEY,   -- unique code (matches TStudent.CityCode)
    CityName    NVARCHAR(100) NOT NULL,               -- name of the city
    Region      NVARCHAR(100) NULL,                   
    ParentCode  VARCHAR(10)   NULL,                   -- link to another CityCode for hierarchy

    CONSTRAINT FK_TCity_Parent 
        FOREIGN KEY (ParentCode) REFERENCES dbo.TCity(CityCode)  -- self reference
);
GO

ALTER TABLE dbo.TStudent
ADD CONSTRAINT FK_TStudent_City
    FOREIGN KEY (CityCode) REFERENCES dbo.TCity(CityCode);
GO




/* ========== Sample data ========== */

INSERT INTO dbo.TCity (CityCode, CityName, Region, ParentCode)
VALUES
 ('020', N'London',        N'England',   NULL),  -- parent city
 ('021', N'Westminster',   N'England',   '020'), -- child of London
 ('011', N'Bristol',       N'England',   NULL),
 ('012', N'Manchester',    N'England',   NULL),
 ('013', N'Cardiff',       N'Wales',     NULL),
 ('014', N'Cambridge',     N'England',   NULL),
 ('015', N'Edinburgh',     N'Scotland',  NULL);


-- Teachers
INSERT INTO dbo.TTeacher (FName, LName, HireDate, [Subject], Email, Phone, Address)
VALUES
 (N'William',  N'Harris',  '2012-09-01', N'Database Systems', 'wharris@example.com',  '07711111111', N'London, King’s Cross'),
 (N'Elizabeth',N'Martin',  '2015-01-15', N'SQL Programming',  'emartin@example.com',  '07722222222', N'Bristol, Park Street'),
 (N'Thomas',   N'Wright',  '2018-04-20', N'Algorithms',       'twright@example.com',  '07733333333', N'Manchester, Deansgate'),
 (N'Charlotte',N'Hall',    '2016-06-10', N'Web Development',  'chall@example.com',    '07744444444', N'Cardiff, City Road'),
 (N'Henry',    N'Green',   '2010-02-01', N'Computer Science', 'hgreen@example.com',   '07755555555', N'Cambridge, Trinity Street');
GO

-- Students
INSERT INTO dbo.TStudent (Code_St, FName, LName, BDate, Education, Gender, D_Reg, CityCode, Telephone, Address)
VALUES
 (1, N'James',   N'Smith',   1998, N'Bachelor',   1, '2015/09/01', '020', '07111111111', N'London, Baker Street'),
 (2, N'Emily',   N'Johnson', 2000, N'Master',     0, '2017/03/15', '011', '07222222222', N'Bristol, Clifton'),
 (3, N'Daniel',  N'Brown',   1997, N'Diploma',    1, '2016/11/20', '012', '07333333333', N'Manchester, Oxford Road'),
 (4, N'Sophie',  N'Wilson',  2002, N'Bachelor',   0, '2019/10/10', '013', '07444444444', N'Cardiff, Queen Street'),
 (5, N'Oliver',  N'Taylor',  1995, N'PhD',        1, '2014/05/22', '014', '07555555555', N'Cambridge, King’s Parade'),
 (6, N'Grace',   N'Evans',   2010, N'HighSchool', 0, '2024/01/12', '015', '07666666666', N'Edinburgh, Princes Street');
GO

/* Teacher IDs are 1..5 in the insert order above */
INSERT INTO dbo.TCourses (Code_Course, Code_Standard, Descriptions, Code_Teacher)
VALUES
 ('C101', '13960101', N'Database Fundamentals',        1), -- William Harris
 ('C102', '13960102', N'SQL Programming',              2), -- Elizabeth Martin
 ('C103', '13960103', N'Algorithms & Data Structures', 3), -- Thomas Wright
 ('C104', '13960104', N'Web Development Basics',       4); -- Charlotte Hall
GO

-- Enrolments: connect Student + Course + Teacher (usually same teacher as the course owner)
INSERT INTO dbo.TCourse_Student (Code_Course, Code_St, Code_Teacher, EnrollDate, Grade, Debt)
VALUES
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

-- Applicants tied to actual courses (clean union/intersect with students, easy joins to teacher/course)
INSERT INTO dbo.TCourse_Applicant (Applicant_Id, FName, LName, Code_Course, ApplyDate, Status)
VALUES
 (101, N'James',     N'Smith',   'C101', '2024-08-01', N'Pending'),
 (102, N'Emily',     N'Johnson', 'C102', '2024-08-05', N'Accepted'),
 (103, N'George',    N'Clark',   'C103', '2024-08-10', N'Pending'),
 (104, N'Charlotte', N'Lewis',   'C104', '2024-08-12', N'Rejected'),
 (105, N'Matthew',   N'Walker',  'C101', '2024-08-15', N'Pending'),
 (106, N'Sophie',    N'Wilson',  'C102', '2024-08-18', N'Accepted');
GO
