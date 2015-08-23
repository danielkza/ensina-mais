class AddInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :age_range, :string
    add_column :users, :location, :string
    add_column :users, :study, :string
    add_column :users, :work, :string
    add_column :users, :info, :string
  end
end
