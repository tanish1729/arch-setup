output = open("output.txt", "w")
print("Enter number of new deadlines")
num = int(input())
course = []
deadline = []
for _ in range(num):
    print("Enter course and deadline")
    response = input()
    course_name = response.split()[0]
    course.append(course_name)
    deadline_date = response.split()[1]
    deadline.append(deadline_date)
final = ""
for i in range(num):
    final = final + " | " + course[i] + " -> " + deadline[i]
final = final + " |"
output.write("content = Deadlines : " + final)
print("Done")