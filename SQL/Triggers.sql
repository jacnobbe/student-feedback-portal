Show Triggers;
DROP TRIGGER IF EXISTS trig_Create_Stats_For_Section;

DELIMITER $$
CREATE TRIGGER trig_Create_Stats_For_Section AFTER INSERT ON Survey
FOR EACH ROW
BEGIN

	DECLARE $sectionNum int;
	DECLARE $courseID varchar(10);
	DECLARE $semester varchar(20);
	DECLARE $currentQuestionID int;
	DECLARE $currentOfferedAnswerID int;
	DECLARE $Finished int DEFAULT 0;

	# Cursor will be used to calculate the percentages for
	# the answered question. This means only considering the surveys about that section.
	DECLARE question_answer_cursor CURSOR FOR
		SELECT questionID, offeredAnswerID FROM Question_Answer
		ORDER BY questionID;

	DECLARE CONTINUE HANDLER
	FOR NOT FOUND SET $Finished = 1;

	# Store data about what section the survey is about, and the answer given
  SELECT sectionNum, courseID, semester
		INTO $sectionNum, $courseID, $semester
    FROM Survey	NATURAL JOIN Enroll
      NATURAL JOIN Section
	WHERE surveyID = NEW.surveyID;

	#  If there are no stats for that section,
	#  then insert every combination of question and answer
	#  into stats table for that section
	IF(NOT exists(SELECT * FROM Question_Answer_Statistics_By_Section
		WHERE sectionNum = $sectionNum
		AND courseID = $courseID
		AND semester = $semester))
	THEN

		# Add an entry in the stats table for every question answer.
		OPEN question_answer_cursor;

		AnswerStat: LOOP

			FETCH question_answer_cursor INTO $currentQuestionID, $currentOfferedAnswerID;

			IF $Finished = 1 THEN
				LEAVE AnswerStat;
			END IF;

			# The percent will default to 0.00
			INSERT INTO Question_Answer_Statistics_By_Section
			(sectionNum, courseID, semester, questionID, offeredAnswerID )
			VALUES ($sectionNum, $courseID, $semester, $currentQuestionID, $currentOfferedAnswerID);

		END LOOP AnswerStat;

		CLOSE question_answer_cursor;

	END IF;

END;
$$
DELIMITER ;




/* Trigger on table answer_choice that updates Question_Answer_Statistics_By_Section  */
DELIMITER $$
CREATE TRIGGER trig_Update_Stats_After_INSERT AFTER INSERT ON Answer_Choice
FOR EACH ROW
BEGIN

	DECLARE $totalAnswerCount int;
	DECLARE $currentOfferedAnswerCount int;
	DECLARE $currentOfferedAnswer int;
	DECLARE $offeredAnswerID int;
	DECLARE $questionID int;
	DECLARE $sectionNum int;
	DECLARE $courseID varchar(10);
	DECLARE $semester varchar(20);
	DECLARE $Finished int DEFAULT 0;

  # Cursor will be used to calculate the percentages for the answered question.
	# This means only considering the surveys about that section.
	DECLARE answer_choice_cursor CURSOR FOR
		SELECT offeredAnswerID, count(offeredAnswerID)
		FROM Answer_Choice
		WHERE questionID = NEW.questionID
			AND surveyID IN (SELECT surveyID FROM Section
			NATURAL JOIN Enroll NATURAL JOIN Survey NATURAL JOIN Answer_Choice
			WHERE sectionNum = $sectionNum
					AND courseID = $courseID
					AND semester = $semester)
		GROUP BY offeredAnswerID;


	DECLARE CONTINUE HANDLER
	FOR NOT FOUND SET $Finished = 1;

	# Store data about what section the answer is about, and the answer given
  SELECT DISTINCT sectionNum, courseID, semester, questionID, offeredAnswerID
		INTO $sectionNum, $courseID, $semester, $questionID, $offeredAnswerID
    FROM Answer_Choice NATURAL JOIN Survey
			NATURAL JOIN Enroll
      NATURAL JOIN Section
	WHERE surveyID = NEW.surveyID
	AND questionID = NEW.questionID
	AND offeredAnswerID = NEW.offeredAnswerID;


	# Calculate the number of answers for the question about the section
	SET $totalAnswerCount =
  (SELECT count(questionID)
   FROM Answer_Choice
   WHERE questionID = NEW.questionID
         AND surveyID IN (SELECT surveyID FROM Section
     NATURAL JOIN Enroll NATURAL JOIN Survey NATURAL JOIN Answer_Choice
   WHERE sectionNum = $sectionNum
         AND courseID = $courseID
         AND semester = $semester));


	OPEN answer_choice_cursor;

	AnswerStat: LOOP

		FETCH answer_choice_cursor INTO $currentOfferedAnswer, $currentOfferedAnswerCount;

		IF $Finished = 1 THEN
			LEAVE AnswerStat;
		END IF;

		UPDATE Question_Answer_Statistics_By_Section
			SET percent = (($currentOfferedAnswerCount/$totalAnswerCount) * 100.0)
			WHERE sectionNum = $sectionNum
				AND courseID = $courseID
				AND semester = $semester
				AND questionID = $questionID
				AND offeredAnswerID = $currentOfferedAnswer;

		END LOOP AnswerStat;

		CLOSE answer_choice_cursor;

END;
$$
DELIMITER ;


Show Triggers;
DROP TRIGGER IF EXISTS trig_Update_Stats_After_DELETE;

/* Trigger on table answer_choice that updates Question_Answer_Statstics */
DELIMITER $$ 
CREATE TRIGGER trig_Update_Stats_After_DELETE AFTER DELETE ON Answer_Choice 
FOR EACH ROW  
BEGIN 
	
	DECLARE $TotalAnswerCount int; 
    DECLARE $OfferedAnswer int; 
	DECLARE $OfferedAnswerCount int; 
    DECLARE $Finished int DEFAULT 0;
    
    DECLARE answer_choice_cursor CURSOR FOR
    SELECT offeredAnswerID, count(offeredAnswerID)
	FROM Answer_Choice
    WHERE questionID = OLD.questionID
	GROUP BY offeredAnswerID;
    
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET $Finished = 1;

    
    SET $TotalAnswerCount = (select count(questionID) 
						from Answer_Choice 
						where questionID = OLD.questionID);
    
    -- Debugging
    SET @TotalAnswerCount = $TotalAnswerCount;
    
    OPEN answer_choice_cursor;
    
    AnswerStat: LOOP
    
    FETCH answer_choice_cursor INTO $OfferedAnswer, $OfferedAnswerCount;
    
    -- Debugging
    SET @OfferedAnswer = $OfferedAnswer;
    SET @OfferedAnswerCount = $OfferedAnswerCount;
    
	IF $Finished = 1 THEN 
		LEAVE AnswerStat;
	END IF;

		UPDATE Question_Answer_Statistics 
		SET percent = (($OfferedAnswerCount/$TotalAnswerCount) * 100.0 )
		WHERE Question_Answer_Statistics.questionID = OLD.questionID
		AND Question_Answer_Statistics.offeredAnswerID = $OfferedAnswer; 
        
	END LOOP AnswerStat;
    
    CLOSE answer_choice_cursor;
    
    
END; 
$$ 
DELIMITER ;

-- DEBUGGING

SELECT @TotalAnswerCount;
SELECT @OfferedAnswer;
SELECT @OfferedAnswerCount;


-- END DEBUGGING



DELIMITER $$ 
CREATE TRIGGER trig_Update_Stats_After_UPDATE AFTER UPDATE ON Answer_Choice 
FOR EACH ROW  
BEGIN 

	DECLARE $NewTotalAnswerCount int; 
    DECLARE $OldTotalAnswerCount int; 
    DECLARE $OfferedAnswer int; 
	DECLARE $OfferedAnswerCount int; 
    DECLARE $NewFinished int DEFAULT 0;
    DECLARE $OldFinished int DEFAULT 0;
    
    DECLARE new_answer_choice_cursor CURSOR FOR
    SELECT offeredAnswerID, count(offeredAnswerID)
	FROM Answer_Choice
    WHERE questionID = NEW.questionID
	GROUP BY offeredAnswerID;
    
    DECLARE old_answer_choice_cursor CURSOR FOR
    SELECT offeredAnswerID, count(offeredAnswerID)
	FROM Answer_Choice
    WHERE questionID = OLD.questionID
	GROUP BY offeredAnswerID;
    
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET $NewFinished = 1;
        
	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET $OldFinished = 1;
    
    SET $NewTotalAnswerCount = (select count(questionID) 
						from Answer_Choice 
						where questionID = NEW.questionID);
                        
	SET $OldTotalAnswerCount = (select count(questionID) 
						from Answer_Choice 
						where questionID = OLD.questionID);
    
    -- Update Stats for New value -----------------------------------------
    OPEN new_answer_choice_cursor;
    
    NewAnswerStat: LOOP
    
    FETCH new_answer_choice_cursor INTO $OfferedAnswer, $OfferedAnswerCount;
    
	IF $finished = 1 THEN 
		LEAVE NewAnswerStat;
	END IF;

		UPDATE Question_Answer_Statistics 
		SET percent = (($OfferedAnswerCount/$NewTotalAnswerCount) * 100.0 )
		WHERE Question_Answer_Statistics.questionID = OLD.questionID
		AND Question_Answer_Statistics.offeredAnswerID = $OfferedAnswer; 
        
	END LOOP NewAnswerStat;
    
    CLOSE new_answer_choice_cursor;
    
    -- Update Stats for old value -----------------------------------------
    OPEN old_answer_choice_cursor;
    
    OldAnswerStat: LOOP
    
    FETCH old_answer_choice_cursor INTO $OfferedAnswer, $OfferedAnswerCount;
    
	IF $finished = 1 THEN 
		LEAVE OldAnswerStat;
	END IF;

		UPDATE Question_Answer_Statistics 
		SET percent = (($OfferedAnswerCount/$OldTotalAnswerCount) * 100.0 )
		WHERE Question_Answer_Statistics.questionID = NEW.questionID
		AND Question_Answer_Statistics.offeredAnswerID = $OfferedAnswer; 
        
	END LOOP OldAnswerStat;
    
    CLOSE old_answer_choice_cursor;
    
END; 
$$ 
DELIMITER ;


Show Triggers;
DROP TRIGGER IF EXISTS trig_Auto_Create_Survey;

DELIMITER $$
CREATE TRIGGER trig_Auto_Create_Survey AFTER INSERT ON Enroll
FOR EACH ROW
BEGIN
	
    DECLARE $SurveyIDMax int;
    SELECT MAX(surveyID) INTO $SurveyIDMax 
    FROM Survey;
    
	INSERT INTO Survey VALUES (NEW.userID, NEW.courseID, NEW.semester, ($SurveyIDMax + 1));
    
END;
$$
DELIMITER ;



Show Triggers;
DROP TRIGGER IF EXISTS trig_Validate_Course_ID;

DELIMITER $$
CREATE TRIGGER trig_Validate_Course_ID BEFORE INSERT ON Course
FOR EACH ROW
BEGIN
	
	IF( NEW.courseID NOT LIKE NEW.departmentID +'%' )
    THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = "Course ID must contain the Department ID associated with the course.";
	END IF;
	
END;
$$
DELIMITER ;



