# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


student = Student.create(email: 'test@example.com', name: 'Test user',
  password: Devise.friendly_token(8))
teacher = Teacher.create(email: 'test2@example.com', name: 'Test teacher',
  password: Devise.friendly_token(8))
industry = Industry.create(email: 'test3@example.com', name: 'Test Industry',
  password: Devise.friendly_token(8))

course = Course.create(industry: industry, teacher: teacher, requirements: "Ensino Fundamental",
  date: "22/08/2015", location: "FIESP", cost: "Grátis")

course.students << student
