class Teacher < User
  has_many :course_offers, class_name: 'CourseOffer', foreign_key: 'teacher_id'
end
