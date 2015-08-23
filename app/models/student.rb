class Student < User
  has_and_belongs_to_many :course_offers, foreign_key: 'student_id'
end
