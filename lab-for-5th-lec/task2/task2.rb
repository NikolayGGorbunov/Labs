require 'stringio'

def read_students(filename_students)
  file = File.open(filename_students)
  students_list = file.readlines.map(&:chomp)
  file.close
  students_list
end

def write_students(students, age, filename_result)
  loop do
    if age.length != 2
       puts 'Age must be between 10 and 99'
       age = $stdin.gets.chomp
    else
      break
    end
  end
  file = File.open(filename_result, 'a')
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

def sort_students(filename_students, filename_result)
  File.delete(filename_result) if File.exist?(filename_result)
  students = read_students(filename_students)
  start_len = students.length
  final_len = 0
  puts students
  puts 'Enter the age of the student'
  while !students.empty?
    students = write_students(students, $stdin.gets.chomp, filename_result)
    final_len += 1
    puts '++++++++++++++++++++++++++++'
    puts students
    puts 'Enter the age of the student'
  end
  [students.empty?, final_len == start_len]
end

#sort_students('students.txt', 'result.txt')
