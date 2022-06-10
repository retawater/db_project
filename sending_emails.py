import mysql.connector
import numpy
import os
import ezgmail

db = mysql.connector.connect(user = 'root', password = 'this_is_not_the_password', host = 'localhost', database = 'test_private_teaching_at_myac')

cursor = db.cursor()

query = "select * from outstanding_payments where remaining_balance > 0"

cursor.execute(query)

data = cursor.fetchall()

unique_emails = numpy.unique(numpy.array([data[i][4] for i in range(4)]))

messages = []

for email in unique_emails:
	messages.append({"email": email, "message":""})

for item in messages:
	lessons = []
	for date, teacher, student_name, remaining_balance, teacher_email in data:
		if teacher_email == item["email"]:
			lessons.append("Lesson on " + str(date) + " with " + str(student_name) + ". Amount Due: $" + str(round(remaining_balance, 2)))
	item["message"] = "Hello,\n\nI am writing to notify you that MYAC has not received payment for the following lesson(s):\n\n" + "\n".join([str(lesson) for lesson in lessons]) + "\n\nYou can pay online or you can bring payment to MYAC the next time you are here. Thank you!\n\nBest\nEvan"

ezgmail.init()
for item in messages:
	ezgmail.send(str(item['email']), 'Payments for teaching at MYAC', str(item['message']))


			
	 
