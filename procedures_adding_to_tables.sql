/*these stored procedures improve workflow for adding single rows to certain tables*/


/*add to lessons*/
DELIMITER //
CREATE PROCEDURE insert_lesson(IN p_teacher_name varchar(50), IN p_student_name varchar(50), IN p_date date, IN p_start_time time, IN p_end_time time)
BEGIN
INSERT INTO lessons(date, start_time, end_time, teacher_id, student_id) 
values (
p_date, 
p_start_time, 
p_end_time,
(SELECT teacher_id FROM teachers WHERE p_teacher_name = CONCAT(first_name, " ", last_name)),
(SELECT student_id FROM students WHERE p_student_name = CONCAT(first_name, " ", last_name))
);
END//
DELIMITER ;

/*example usage*/
/* CALL insert_lesson('[teacher full name]', '[student full name]', '[date of lesson]', '[start time]', '[end time]'); */  

/************************************************************************************************************************/
/*add to teachers*/
DELIMITER //
CREATE PROCEDURE insert_teacher(IN p_teacher_name varchar(50), IN p_email varchar(50), IN p_instrument varchar(5))
BEGIN
INSERT INTO teachers(first_name, last_name, email, instrument) 
values (
substring_index(p_teacher_name, " ", 1), 
substring_index(p_teacher_name, " ", -1),
p_email,
p_instrument
);
END//
DELIMITER ;

/*example usage*/
/* CALL insert_teacher('[teacher full name]', '[email]', '[instrument]'); */

/************************************************************************************************************************/
/*add to students (no instrument column in test version currently loaded)*/
DELIMITER //
CREATE PROCEDURE insert_student(IN p_student_name varchar(50), IN p_email varchar(50), IN p_enrollment_status tinyint, IN p_instrument varchar(50), IN p_teacher_name varchar(50))
BEGIN
INSERT INTO students(first_name, last_name, email, enrollment_status, instrument, teacher_id) 
values (
substring_index(p_student_name, " ", 1), 
substring_index(p_student_name, " ", -1),
p_email,
p_enrollment_status,
p_instrument,
(SELECT teacher_id FROM teachers WHERE p_teacher_name = CONCAT(first_name, " ", last_name))
);
END//
DELIMITER ;

/*example usage */
/* CALL insert_student('[student full name]', '[email]', '[1 if enrolled, 0 if not]', '[instrument]', '[teacher full name]');
