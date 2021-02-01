class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uid, unique: true, null: false, index: true
      t.string :password_digest, null: false, index: true

      t.timestamps null: false
    end
  end
end
