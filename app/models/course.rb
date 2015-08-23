class Course < ActiveRecord::Base
  has_and_belongs_to_many :teachers, join_table: 'courses_teachers',
                          association_foreign_key: 'teacher_id'
  has_and_belongs_to_many :industries, join_table: 'courses_industries',
                          association_foreign_key: 'industry_id'

  has_many :offers, class_name: 'CourseOffer'
  has_many :ratings, class_name: 'CourseRating'

  def rating
    ratings.average(:rating)
  end
end
