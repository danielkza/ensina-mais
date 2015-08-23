class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :industry, foreign_key: false
      t.references :teacher, foreign_key: false
      t.string :date
      t.string :location
      t.string :requirements
      t.string :cost

      t.timestamps null: false

      t.foreign_key :users, column: 'industry_id'
      t.foreign_key :users, column: 'teacher_id'
    end

    create_table :courses_students do |t|
      t.references :course, foreign_key: true
      t.references :student
      t.foreign_key :users, column: 'student_id'
    end
  end
end
