class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.string :title, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
