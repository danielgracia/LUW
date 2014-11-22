class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :body
    end

    add_index :tags, :body

    create_join_table :tags, :contents
  end
end
