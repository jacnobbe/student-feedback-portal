DROP TABLE IF EXISTS Answer_Choice;
DROP TABLE IF EXISTS Question_Answer;
DROP TABLE IF EXISTS Answer_Text;
DROP TABLE IF EXISTS Question;
DROP TABLE IF EXISTS OfferedAnswer;
DROP TABLE IF EXISTS Enroll;
DROP TABLE IF EXISTS Section;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS ProfessorToDepartment;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS UserType;


-- Student, Admistator
CREATE TABLE UserType(
	userTypeID int PRIMARY KEY,
    description varchar(20) NOT NULL
);

CREATE TABLE User (
	userID int PRIMARY KEY,
    userPassword varchar(30) NOT NULL,
    userFName varchar(25) NOT NULL,
    userLName varchar(25) NOT NULL,
    userTypeID int,
    FOREIGN KEY (userTypeID) REFERENCES UserType
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Student (
	userID int PRIMARY KEY,
	currentYear int,
	major	varchar(50) NOT NULL,
    FOREIGN KEY (userID) REFERENCES User (userID)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Professor (
	professorID int PRIMARY KEY,
	professorFName varchar(25) NOT NULL,
    professorLName varchar(25) NOT NULL
);

CREATE TABLE Department (
	departmentID varchar (5) PRIMARY KEY,
	departmentName varchar (50) NOT NULL
);

CREATE TABLE ProfessorToDepartment(
	professorID int,
    departmentID varchar(5),
    PRIMARY KEY (professorID, departmentID),
    FOREIGN KEY (professorID) REFERENCES Professor (professorID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (departmentID) REFERENCES Department (departmentID)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Course (
	courseID varchar (10) PRIMARY KEY,
  courseName varchar (60) NOT NULL,
	departmentID varchar (5) NOT NULL,
	FOREIGN KEY (departmentID) REFERENCES Department (departmentID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);


CREATE TABLE Section (
	sectionNum int,
	courseID varchar (10) NOT NULL,
	semester varchar (20),
    professorID int NOT NULL,
	PRIMARY KEY (sectionNum, courseID, semester),
	FOREIGN KEY (courseID) REFERENCES Course (courseID)
		ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (professorID) REFERENCES Professor (professorID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Enroll (
	studentID int,
    courseID varchar (10),
	semester varchar(20),
	sectionNum int NOT NULL,
	PRIMARY KEY (studentID, courseID, semester),
	FOREIGN KEY (studentID) REFERENCES Student (studentID)
		ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (sectionNum) REFERENCES Section (sectionNum)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE OfferedAnswer (
	offeredAnswerID int PRIMARY KEY,
    answerText varchar (40) NOT NULL
);

CREATE TABLE Question (
	questionID	int PRIMARY KEY,
	questionText  varchar(128) NOT NULL,
	answerType	varchar(20) NOT NULL
);


CREATE TABLE Answer_Text (
	studentID int,
	questionID int,
	answer varchar(500) NOT NULL,
	PRIMARY KEY (studentId, questionID),
	FOREIGN KEY (questionID) REFERENCES Question (questionID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (studentID) REFERENCES Student (studentID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Question_Answer (
	questionID int,
    offeredAnswerID int,
    PRIMARY KEY (questionID, offeredAnswerID),
    FOREIGN KEY (questionID) REFERENCES Question (questionID)
		ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (offeredAnswerID) REFERENCES OfferedAnswer (offeredAnswerID)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Answer_Choice (
	studentID int,
	questionID int,
	offeredAnswerID int NOT NULL,
	PRIMARY KEY (studentId, questionID),
    FOREIGN KEY (offeredAnswerID) REFERENCES OfferedAnswer (offeredAnswerID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (questionID) REFERENCES Question (questionID)
		ON UPDATE CASCADE ON DELETE CASCADE,
	 FOREIGN KEY (studentID) REFERENCES Student (studentID)
		 ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Result_Choice(
	questionID int,
    offeredAnswerID int,
    percent decimal(3,2) NOT NULL,
    PRIMARY KEY (questionID, offeredAnswerID),
    FOREIGN KEY (questionID, offeredAnswerID) REFERENCES Answer_Choice (questionID, offeredAnswerID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE Result_Text(
	studentID int,
	questionID int,
    voteCount int,
    PRIMARY KEY (studentID, questionID),
    FOREIGN KEY (studentID, questionID) REFERENCES Answer_Text (studentID, questionID)
		ON UPDATE CASCADE ON DELETE NO ACTION
);
