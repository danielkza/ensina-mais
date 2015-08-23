class Course < ActiveRecord::Base
  belongs_to :industry
  belongs_to :teacher

  has_and_belongs_to_many :students, join_table: 'courses_students',
                          association_foreign_key: 'student_id'
end
