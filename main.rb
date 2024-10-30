require 'date'

class Student
  @@students = []

  attr_reader :surname, :name, :date_of_birth

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name

    if Date.parse(date_of_birth) < Date.today
      @date_of_birth = Date.parse(date_of_birth)
    else
      raise ArgumentError, 'Invalid date of birth.'
    end

    unless duplicate_exists?
      @@students << self
    end
  end

  def duplicate_exists?
    @@students.any? do |student|
      student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth
    end
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    if Date.new(today < @date_of_birth + age.years)
      age -= 1 
    end

    age
  end

  def self.add_student(surname, name, date_of_birth)
    begin
      Student.new(surname, name, date_of_birth)
    rescue ArgumentError => e
      puts "Error adding student: #{e.message}"
    end
  end

  def self.remove_student(surname, name, date_of_birth)
    @@students.delete_if { |student| student.name == name && student.date_of_birth == date_of_birth}
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.students
    @@students
  end
end