class FixUniqueIndexes < ActiveRecord::Migration
  def change
    add_index :course_offers_students, [:course_offer_id, :student_id], unique: true
    add_index :course_ratings, [:course_id, :user_id], unique: true
    add_index :courses_teachers, [:course_id, :teacher_id], unique: true
    add_index :courses_industries, [:course_id, :industry_id], unique: true
    add_index :users, [:uid, :provider], unique: true
  end
end
