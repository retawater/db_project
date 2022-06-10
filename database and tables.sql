/*create database*/
CREATE DATABASE test_private_teaching_at_myac
CHARACTER SET utf8;
/*collation is default*/

USE test_private_teaching_at_MYAC

/*create tables*/

CREATE TABLE teachers(
teacher_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(50),
instrument VARCHAR(50)
);

CREATE TABLE students(
student_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(50),
enrollment_status TINYINT,
instrument VARCHAR(50),
teacher_id INT,
CONSTRAINT fk_students_teacher_id
FOREIGN KEY (teacher_id)
REFERENCES teachers(teacher_id)
);

CREATE TABLE lesson_block(
lesson_block_id INT AUTO_INCREMENT PRIMARY KEY,
day VARCHAR(10),
start_time TIME,
end_time TIME,
teacher_id INT,
CONSTRAINT fk_lesson_block_teacher_id
FOREIGN KEY (teacher_id)
REFERENCES teachers(teacher_id)
);

CREATE TABLE lessons(
lesson_id INT AUTO_INCREMENT PRIMARY KEY,
date DATE,
start_time TIME,
end_time TIME,
teacher_id INT,
student_id INT,
CONSTRAINT fk_teacher_id_lessons
FOREIGN KEY (teacher_id)
REFERENCES teachers(teacher_id),
CONSTRAINT fk_student_id_lessons
FOREIGN KEY (student_id)
REFERENCES students(student_id)
);

CREATE TABLE payments(
payment_id INT AUTO_INCREMENT PRIMARY KEY,
lesson_id INT,
amount INT,
CONSTRAINT fk_lesson_id_payments
FOREIGN KEY (lesson_id)
REFERENCES lessons(lesson_id)
);
