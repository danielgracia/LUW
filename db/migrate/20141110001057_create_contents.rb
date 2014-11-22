class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references :user, index: true
      
      t.string  :title
      t.text    :body
      t.string  :attachment_path
      t.integer :score
      t.boolean :closed

      t.timestamps null: false
    end
  end
end
