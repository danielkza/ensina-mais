class AddFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :field, :string
  end
end
