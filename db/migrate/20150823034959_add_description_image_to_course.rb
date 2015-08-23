class AddDescriptionImageToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :description, :string
    add_column :courses, :image, :string
  end
end
