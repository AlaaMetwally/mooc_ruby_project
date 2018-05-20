class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :date_of_birth
      t.string :gender
      t.string :profile_picture
      t.integer :created_by
      t.column :user_type, :integer, default: 2
      t.timestamps
    end
  end
end
