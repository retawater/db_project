/*This view contains lesson info, teacher info, and amount due in each row*/

CREATE VIEW outstanding_payments AS
SELECT 
lessons.date AS date, 
CONCAT(teachers.first_name, " ", teachers.last_name) AS teacher_name,
CONCAT(students.first_name, " ", students.last_name) AS student_name,
CASE 
   WHEN (students.enrollment_status = 1) 
   THEN 0
   ELSE 
      CASE 
      WHEN (lessons.lesson_id IN (SELECT lesson_id FROM payments)) 
         THEN ((TIMESTAMPDIFF(MINUTE, lessons.start_time, lessons.end_time)*(1.0/6.0))-payments.amount)
         ELSE TIMESTAMPDIFF(MINUTE, lessons.start_time, lessons.end_time)*(1.0/6.0)
      END
END AS remaining_balance,
teachers.email AS teacher_email
FROM lessons
LEFT JOIN teachers
ON lessons.teacher_id = teachers.teacher_id
LEFT JOIN students
ON lessons.student_id = students.student_id
LEFT JOIN payments
ON lessons.lesson_id = payments.lesson_id;
