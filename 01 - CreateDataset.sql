-- Students
CREATE TABLE dbo.TStudent
(
    Code_St      INT            NOT NULL PRIMARY KEY,           -- student ID
    FName        NVARCHAR(50)   NULL,
    LName        NVARCHAR(50)   NULL,
    BDate        SMALLINT       NULL,    
    Education    NVARCHAR(50)   NULL,
    Gender       SMALLINT       NULL,   
    D_Reg        VARCHAR(10)    NULL,    
    CityCode     VARCHAR(10)    NULL,
    Telephone    VARCHAR(20)    NULL,
    Address      NVARCHAR(200)  NULL,
    CONSTRAINT CK_TStudent_BDate CHECK (BDate BETWEEN 1900 AND 2100)
);
GO

-- Courses
CREATE TABLE dbo.TCourses
(
    Code_Course    VARCHAR(10)    NOT NULL PRIMARY KEY,
    Code_Standard  VARCHAR(20)    NULL,
    Descriptions   NVARCHAR(200)  NULL
);
GO

-- Student–Course (enrolments, grades, debts)
CREATE TABLE dbo.TCourse_Student
(
    Code_Course  VARCHAR(10)   NOT NULL,
    Code_St      INT           NOT NULL,
    Grade        DECIMAL(5,2)  NULL,
    Debt         DECIMAL(10,2) NOT NULL CONSTRAINT DF_TCourse_Student_Debt DEFAULT (0),

    CONSTRAINT PK_TCourse_Student PRIMARY KEY (Code_Course, Code_St),
    CONSTRAINT FK_TCourse_Student_Course
        FOREIGN KEY (Code_Course) REFERENCES dbo.TCourses(Code_Course),
    CONSTRAINT FK_TCourse_Student_Student
        FOREIGN KEY (Code_St)     REFERENCES dbo.TStudent(Code_St)
);
GO

-- Applicant table (for prospective students who applied but may not be enrolled)
CREATE TABLE dbo.TCourse_Applicant
(
    Applicant_Id   INT            NOT NULL PRIMARY KEY,      -- unique applicant id
    FName          NVARCHAR(50)   NULL,
    LName          NVARCHAR(50)   NULL,
    Code_Standard  VARCHAR(20)    NOT NULL,                  -- links to course standard code
    ApplyDate      DATE           NULL,
    Status         NVARCHAR(20)   NULL                       
);
GO

-- Insert teachers
CREATE TABLE dbo.TTeacher
(
    Code_Teacher   INT IDENTITY(1,1) PRIMARY KEY,  -- auto-increment starting at 1
    FName          NVARCHAR(50)   NOT NULL,
    LName          NVARCHAR(50)   NOT NULL,
    HireDate       DATE           NULL,
    Subject        NVARCHAR(100)  NULL,
    Email          NVARCHAR(100)  NULL,
    Phone          VARCHAR(20)    NULL,
    Address        NVARCHAR(200)  NULL
);
CREATE INDEX IX_TTeacher_Subject ON dbo.TTeacher(Subject);




-- Helpful indexes 
CREATE INDEX IX_TStudent_DReg          ON dbo.TStudent(D_Reg);
CREATE INDEX IX_TCourses_CodeStandard  ON dbo.TCourses(Code_Standard);
CREATE INDEX IX_TCourse_Student_St     ON dbo.TCourse_Student(Code_St);
CREATE INDEX IX_TCourse_Applicant_Code ON dbo.TCourse_Applicant(Code_Standard);
GO

 
 

-- Students
INSERT INTO dbo.TStudent (Code_St, FName, LName, BDate, Education, D_Reg, CityCode, Telephone, Address)
VALUES
 (1, N'James',   N'Smith',     1998, N'Bachelor',   '2015/09/01', '020', '07111111111', N'London, Baker Street', 1),
 (2, N'Emily',   N'Johnson',   2000, N'Master',     '2017/03/15', '011', '07222222222', N'Bristol, Clifton', 0),
 (3, N'Daniel',  N'Brown',     1997, N'Diploma',    '2016/11/20', '012', '07333333333', N'Manchester, Oxford Road', 2),
 (4, N'Sophie',  N'Wilson',    2002, N'Bachelor',   '2019/10/10', '013', '07444444444', N'Cardiff, Queen Street', 2),
 (5, N'Oliver',  N'Taylor',    1995, N'PhD',        '2014/05/22', '014', '07555555555', N'Cambridge, King’s Parade', 1),
 (6, N'Grace',   N'Evans',     2010, N'HighSchool', '2024/01/12', '015', '07666666666', N'Edinburgh, Princes Street', 2);
GO

-- Courses
INSERT INTO dbo.TCourses (Code_Course, Code_Standard, Descriptions)
VALUES
 ('C101', '13960101', N'Database Fundamentals'),
 ('C102', '13960102', N'SQL Programming'),
 ('C103', '13960103', N'Algorithms & Data Structures'),
 ('C104', '13960104', N'Web Development Basics');
GO

-- Enrollments (Student ↔ Course)
INSERT INTO dbo.TCourse_Student (Code_Course, Code_St, Grade, Debt)
VALUES
 ('C101', 1,  18.50, 0.00),
 ('C101', 2,  16.00, 0.00),
 ('C101', 3,  12.00, 50.00),
 ('C102', 1,  15.75, 0.00),
 ('C102', 4,  NULL,  200.00),   -- not graded yet
 ('C103', 5,  19.25, 0.00),
 ('C103', 6,  13.00, 0.00),
 ('C104', 2,  14.50, 100.00),
 ('C104', 3,  NULL,  0.00),
 ('C104', 4,  17.75, 0.00);
GO


INSERT INTO dbo.TCourse_Applicant (Applicant_Id, FName, LName, Code_Standard, ApplyDate, Status)
VALUES
 (101, N'James',   N'Smith',    '13960101', '2024-08-01', N'Pending'),     -- same as student 1
 (102, N'Emily',   N'Johnson',  '13960102', '2024-08-05', N'Accepted'),    -- same as student 2
 (103, N'George',  N'Clark',    '13960103', '2024-08-10', N'Pending'),     -- new applicant
 (104, N'Charlotte',N'Lewis',   '13960104', '2024-08-12', N'Rejected'),    -- new applicant
 (105, N'Matthew', N'Walker',   '13960101', '2024-08-15', N'Pending'),     -- new applicant
 (106, N'Sophie',  N'Wilson',   '13960102', '2024-08-18', N'Accepted');    -- same as student 4
GO


INSERT INTO dbo.TTeacher ( FName, LName, HireDate, [Subject], Email, Phone, Address)
VALUES
 (  N'William', N'Harris',  '2012-09-01', N'Database Systems',    'wharris@example.com',  '07711111111', N'London, King’s Cross'),
 ( N'Elizabeth',N'Martin', '2015-01-15', N'SQL Programming',     'emartin@example.com',  '07722222222', N'Bristol, Park Street'),
 ( N'Thomas',  N'Wright',  '2018-04-20', N'Algorithms',          'twright@example.com',  '07733333333', N'Manchester, Deansgate'),
 ( N'Charlotte',N'Hall',   '2016-06-10', N'Web Development',     'chall@example.com',    '07744444444', N'Cardiff, City Road'),
 ( N'Henry',   N'Green',   '2010-02-01', N'Computer Science',    'hgreen@example.com',   '07755555555', N'Cambridge, Trinity Street');
GO
