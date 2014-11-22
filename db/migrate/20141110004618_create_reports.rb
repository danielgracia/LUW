class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :reportable, polymorphic: true, index: true
      t.references :user

      t.text    :reason
      t.boolean :valid

      t.timestamps null: false
    end
  end
end
