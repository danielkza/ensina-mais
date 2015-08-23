class RemoveAssociationsFromCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :industry_id
    remove_column :courses, :teacher_id

    create_table :courses_teachers do |t|
      t.references :course, index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: false
      t.foreign_key :users, column: 'teacher_id'
    end

    create_table :courses_industries do |t|
      t.references :course, index: true, foreign_key: true
      t.references :industry, index: true, foreign_key: false
      t.foreign_key :users, column: 'industry_id'
    end
  end
end
