class RenameCourseStudentsToCourseOffersStudents < ActiveRecord::Migration
  def change
    rename_table :courses_students, :course_offers_students
  end
end
