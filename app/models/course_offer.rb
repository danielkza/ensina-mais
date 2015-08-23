class CourseOffer < ActiveRecord::Base
  belongs_to :course
  belongs_to :industry, class_name: 'Industry'
  belongs_to :teacher, class_name: 'Teacher'

  has_and_belongs_to_many :students, join_table: 'course_offers_students',
                          association_foreign_key: 'student_id'
end
