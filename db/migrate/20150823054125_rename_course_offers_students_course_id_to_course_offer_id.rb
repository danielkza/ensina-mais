class RenameCourseOffersStudentsCourseIdToCourseOfferId < ActiveRecord::Migration
  def change
    rename_column :course_offers_students, :course_id, :course_offer_id
  end
end
