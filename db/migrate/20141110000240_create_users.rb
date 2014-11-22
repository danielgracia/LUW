class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :email, index: true
      t.string  :password_digest
      t.string  :photo_path
      t.boolean :banned
      t.text    :profile
      t.integer :reputation            
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
