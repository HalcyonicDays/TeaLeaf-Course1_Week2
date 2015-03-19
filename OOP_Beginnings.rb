class Vehicle
  @@total_vehicles = 0
  def initialize (year, model, color)
    @year = year
    @model = model
    @color = color
    @speed = 0
    @@total_vehicles +=1
  end

  def how_many
    puts @@total_vehicles
  end
  
  def speed_up
    self.speed += 5
    puts "Speed increased to #{self.speed}"
  end

  def brake
    self.speed > 0 ? self.speed -= 5 : speed
    puts "Speed reduced to #{self.speed}"
  end

  def shut_off
    self.speed = 0
    puts "Car has been shut off."
  end

  def spray_paint(new_color)
    self.color = new_color
  end

  def age
    puts "This vehicle is #{how_old} years old."
  end  

  private
  def how_old
    Time.now.year - self.year
  end  

end

module Loadable
  def load_up(items)
    puts "You've loaded some #{items} into your truck."
  end
end

class MyCar < Vehicle
  attr_accessor :speed, :color
  attr_reader   :year, :model

  NUMBER_OF_DOORS = 4

  def to_s
    "This car is a #{color} #{@year} #{@model}."
  end

  def self.gas_mileage(miles, gallons)
    puts "This car gets #{miles/gallon} miles per gallon."
  end 
end

class MyTruck < Vehicle
  include Loadable

  attr_accessor :speed, :color
  attr_reader   :year, :model

  NUMBER_OF_DOORS = 2

  def initialize(year, model, color)
    super
  end

  def to_s
    "This truck is a #{self.color} #{self.year} #{self.model}."
  end

  def self.gas_mileage(miles, gallons)
    puts "This truck gets #{miles/gallon} miles per gallon."
  end 
end


lumina = MyCar.new(1997, 'chevy lumina', 'white')
chavelier = MyCar.new(2001, 'chevy chavelier', 'red')
ram = MyTruck.new(2003, "dodge ram", "black")

puts lumina
lumina.how_many
puts ram.age
#puts MyCar.ancestors
#puts MyTruck.ancestors
#puts Vehicle.ancestors


class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

steve = Student.new("Steve", 85)
bob = Student.new("Bob", 70)
#puts steve.grade
puts "well done!" if steve.better_grade_than?(bob)
p steve.instance_variables



class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

class Box
  def initialize(h, w)
    @height = h
    @width = w
  end

  def getheight
    puts "this is the getter."
    @height
  end

  def setheight=(new_h)
    puts "this is the setter"
    @height = new_h
  end

  def setheight(new_h)
    puts "this is just a method"
    @height = new_h
  end
end

box1 = Box.new(10, 20)
puts "the height is #{box1.getheight}"
box1.setheight = 20
puts "the height is #{box1.getheight}"
box1.setheight(30)
puts "the height is #{box1.getheight}"




