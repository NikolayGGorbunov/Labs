def read_students(file_name)
  file = File.open(file_name)
  students_list = file.readlines.map(&:chomp)
  file.close
  students_list
end

def write_students(students, age)
  file = File.open('result.txt', 'a')
  written_students = Array.new
  students.map do |student|
    if student.include?(age)
      file.write(student + "\n")
      written_students << student
    end
  end
  file.close
  students - written_students
end

File.delete('result.txt') if File.exist?('result.txt')
students = read_students('students.txt')
while !students.empty?
  students = write_students(students, gets.chomp)
  puts students
end
