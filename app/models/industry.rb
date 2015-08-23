class Industry < User
  has_many :course_offers, class_name: 'CourseOffer', foreign_key: 'industry_id'
end
