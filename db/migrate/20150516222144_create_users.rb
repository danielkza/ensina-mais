class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :facebook_id
      t.string :facebook_token

      t.timestamps null: false
    end
  end
end
