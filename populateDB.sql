/* insert into UserType */
INSERT INTO UserType VALUES (0, 'Administrator'); 
INSERT INTO UserType VALUES (1, 'Student'); 

/* insert into System_User table*/
INSERT INTO System_User VALUES ( 59609,'AUI','Imane','Charrafi', 1);
INSERT INTO System_User VALUES ( 64313,'AUI','Dounia','Marbouh', 1);
INSERT INTO System_User VALUES ( 71006,'AUI','Brandon','Crane', 1);
INSERT INTO System_User VALUES ( 71007,'AUI','Jacqueline','Nobbe', 1);
INSERT INTO System_User VALUES ( 63744,'AUI','Assia','Chadli', 1);
INSERT INTO System_User VALUES ( 59603,'AUI','Yousra',' Gaimes', 1);

/* insert into student table*/
INSERT INTO Student VALUES ( 59609, 4, 'Computer Science');
INSERT INTO Student VALUES ( 64313, 3,'Engineering & Management Science');
INSERT INTO Student VALUES ( 71006, 3, 'Computer Science');
INSERT INTO Student VALUES ( 71007, 3, 'Computer Science');
INSERT INTO Student VALUES ( 63744, 3, 'Engineering & Management Science');
INSERT INTO Student VALUES ( 59603, 4, 'Computer Science');


/* insert into Department*/
INSERT INTO Department VALUES ('CSC', ' Computer Science');
INSERT INTO Department VALUES ('EMS','Engineering & Management Science');
INSERT INTO Department VALUES ('GE','General Engineering');
INSERT INTO Department VALUES ('BA','Business Administration');
INSERT INTO Department VALUES ('IS','International Studies');
INSERT INTO Department VALUES ('CS','Communication Studies');
INSERT INTO Department VALUES ('HRD','Human Resources Development');
INSERT INTO Department VALUES ('LC', ' Language Center');


/* insert into professor*/
INSERT INTO Professor VALUES (1, 'Nasser','Assem');
INSERT INTO Professor VALUES (2, 'Djallil',' Lounnas');
INSERT INTO Professor VALUES (3, 'Jamila','El Kilani');
INSERT INTO Professor VALUES (4, 'Anas','Bentamy');
INSERT INTO Professor VALUES (5, 'Hanaa','Talei');
INSERT INTO Professor VALUES (6, 'Rhizlane','Hammoud');


/* insert into ProfessorToDepartment */
INSERT INTO ProfessorToDepartment VALUES ('1','CSC');
INSERT INTO ProfessorToDepartment VALUES ('4','GE');
INSERT INTO ProfessorToDepartment VALUES ('2','BA');
INSERT INTO ProfessorToDepartment VALUES ('2','CS');

/*insert into course */
INSERT INTO Course VALUES ('CSC 3323','Analysis of Algorithms', 'CSC');
INSERT INTO Course VALUES ('GBU 3303','Enterprises, Markets and the Moroccan Economy','BA');
INSERT INTO Course VALUES ('CSC 3325','Software Engineering 2','CSC');
INSERT INTO Course VALUES ('EGR 2402','Electric Circuits','GE');
INSERT INTO Course VALUES ('CSC 3351','Operating Systems','CSC');
INSERT INTO Course VALUES ('ACC 2301','Accounting Principles 1', 'BA');
INSERT INTO Course VALUES ('CSC 2302','Data Structures','CSC');
INSERT INTO Course VALUES ('CSC 2304','Computer Architecture','CSC');
INSERT INTO Course VALUES ('FRN 2310','French For Academic Purposes 2','LC');
INSERT INTO Course VALUES ('CSC 3326','Database Systems','CSC');
INSERT INTO Course VALUES ('SSC 2302','Social Theory','IS');
INSERT INTO Course VALUES ('COM 3301','Public Relations Communication','CS');
INSERT INTO Course VALUES ('ARA 1311','Beginning Arabic 1','LC');
INSERT INTO Course VALUES ('HRD 4303','Leadership and Management Development','HRD');


/*insert into section*/
INSERT INTO Section VALUES (01,'GBU 3303','Spring 2016',6);
INSERT INTO Section VALUES (02,'CSC 3326','Fall 2016',1);
INSERT INTO Section VALUES (01,'CSC 2302','Fall 2016',5);
INSERT INTO Section VALUES (02,'HRD 4303','Spring 2015',2);
INSERT INTO Section VALUES (02,'EGR 2402','Summer 2016',4);


/* insert into enroll*/
INSERT INTO Enroll VALUES (64313,'GBU 3303','Spring 2014',01);
INSERT INTO Enroll VALUES (71006,'CSC 3326','Fall 2016',01);
INSERT INTO Enroll VALUES (59603,'CSC 2302','Summer 2015',01);
INSERT INTO Enroll VALUES (59609,'CSC 2304','Fall 2016',01);
INSERT INTO Enroll VALUES (71007,'CSC 3326','Fall 2016',01);


/*
/* insert into OfferedAnswer */
INSERT INTO OfferedAnswer VALUES (1,'1-2'); 
INSERT INTO OfferedAnswer VALUES (2,'2-4'); 
INSERT INTO OfferedAnswer VALUES (3,'4-6'); 
INSERT INTO OfferedAnswer VALUES (4,'6-8'); 
INSERT INTO OfferedAnswer VALUES (5,'8-10'); 


/* insert into question */
INSERT INTO Question VALUES ( 1,'How many hours do you spend on the homework?','choice');
INSERT INTO Question VALUES ( 2,'Is the material covered in class relevant to the course?','text');
INSERT INTO Question VALUES ( 3,'How many classes sessions did you miss?','choice');
INSERT INTO Question VALUES ( 4,'Does the professor demonstrate good knowledge of the class material?','text');
INSERT INTO Question VALUES ( 5,'Please identify what you consider to be the weaknesses and the strengths of this class','text');


/* insert into answer_text */
INSERT INTO Answer_Text VALUES (59609,2,'The material covered in class is not very relevant to the course!');
INSERT INTO Answer_Text VALUES (71006,2,' This class taught me how to apply theory to practice');
INSERT INTO Answer_Text VALUES (64313,2,'I think that the professor demonstrates good knowledge of the material');
INSERT INTO Answer_Text VALUES (63744,2,'Students participation is encouraged');
INSERT INTO Answer_Text VALUES (59603,2,'The professor gives a lot of assignments and pop quizzes');


/* insert into Question_Answer */
INSERT INTO Question_Answer VALUES (1,'2'); 
INSERT INTO Question_Answer VALUES (2,'3'); 
INSERT INTO Question_Answer VALUES (3,'5'); 
INSERT INTO Question_Answer VALUES (4,'1'); 
INSERT INTO Question_Answer VALUES (5,'4'); 


/* insert into answer_choice */
INSERT INTO Answer_Choice VALUES (59609,3,2);
INSERT INTO Answer_Choice VALUES (71006,4,1);
INSERT INTO Answer_Choice VALUES (64313,1,5);
INSERT INTO Answer_Choice VALUES (59603,2,3);
INSERT INTO Answer_Choice VALUES (64313,5,4);

/* insert into Answer_Choice_Statistics 
INSERT INTO Answer_Choice_Statistics VALUES (); 

/* insert into Answer_Text_Statistics 
INSERT INTO Answer_Text_Statistics VALUES (); 

*/