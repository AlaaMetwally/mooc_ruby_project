class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.text :content
      t.text :upload_file
      t.references :user, foreign_key: {on_delete: :cascade}
      t.references :course, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
