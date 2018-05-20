class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.references :user, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
