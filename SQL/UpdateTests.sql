# For trigger trig_Update_Stats_After_INSERT

# 1) Get section the answer choice was about
 SELECT DISTINCT sectionNum, courseID, semester, questionID, offeredAnswerID
    FROM Answer_Choice NATURAL JOIN Survey
			NATURAL JOIN Enroll
      NATURAL JOIN Section
	WHERE surveyID = 2
	AND questionID = 1
	AND offeredAnswerID = 2;

# 2) declare cursor for this query
SELECT offeredAnswerID, count(offeredAnswerID)
		FROM Answer_Choice
		WHERE questionID = 1
			AND surveyID IN (SELECT surveyID FROM Section
			NATURAL JOIN Enroll NATURAL JOIN Survey NATURAL JOIN Answer_Choice
			WHERE sectionNum = 1
					AND courseID = 'CSC 3326'
					AND semester = 'Fall 2016')
		GROUP BY offeredAnswerID;

# Testing subqueries
SELECT * FROM Section
			NATURAL JOIN Enroll NATURAL JOIN Survey NATURAL JOIN Answer_Choice
			WHERE sectionNum = 1
					AND courseID = 'CSC 3326'
					AND semester = 'Fall 2016';


# 3) calculate the number of answers for that question and about that section.
SELECT count(questionID)
   FROM Answer_Choice
   WHERE questionID = 1
         AND surveyID IN (SELECT surveyID FROM Section
     NATURAL JOIN Enroll NATURAL JOIN Survey NATURAL JOIN Answer_Choice
   WHERE sectionNum = 1
         AND courseID = 'CSC 3326'
         AND semester = 'Fall 2016');

# 4) Update percentages for each of the offered answers in this question.
UPDATE Question_Answer_Statistics_By_Section
			SET percent = ((1/2) * 100.0)
			WHERE sectionNum = 1
				AND courseID = 'CSC 3326'
				AND semester = 'Fall 2016'
				AND questionID = 1
				AND offeredAnswerID = 1;

# End for trigger trig_Update_Stats_After_INSERT

# --------------------------------------------------------------------------

# For trigger trig_Create_Stats_For_Section

# 1) Store data about what section the survey is about, and the answer given
SELECT sectionNum, courseID, semester
    FROM Survey	NATURAL JOIN Enroll
      NATURAL JOIN Section
	WHERE surveyID = 2;

# 2) check to see if there is already a row for this question about this section in the stats table
SELECT * FROM Question_Answer_Statistics_By_Section
		WHERE sectionNum = 1
		AND courseID = 'CSC 3326'
		AND semester = 'Fall 2016';

# 3) Add an entry in the stats table for every question answer.
SELECT questionID, offeredAnswerID FROM Question_Answer
ORDER BY questionID;
# Loop
# 4) If not, Insert a row in. Percent will default to 0.00
INSERT INTO Question_Answer_Statistics_By_Section
			(sectionNum, courseID, semester, questionID, offeredAnswerID)
			VALUES (1, 'CSC 3326', 'Fall 2016', 1, 2);
# End Loop

