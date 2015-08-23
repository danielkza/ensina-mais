class Student < User
  has_and_belongs_to_many :courses, join_table: 'courses_students',
                          foreign_key: 'student_id'

end
