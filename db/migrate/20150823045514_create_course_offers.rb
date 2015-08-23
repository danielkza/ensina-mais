class CreateCourseOffers < ActiveRecord::Migration
  def change
    create_table :course_offers do |t|
      t.references :course, index: true, foreign_key: true
      t.references :industry, index: true, foreign_key: false
      t.references :teacher, index: true, foreign_key: false
      t.string :date
      t.string :location

      t.foreign_key :users, column: 'industry_id'
      t.foreign_key :users, column: 'teacher_id'

      t.timestamps null: false
    end

    remove_column :courses, :date
    remove_column :courses, :location
  end
end
