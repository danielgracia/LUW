class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :user
      t.boolean    :used,  default: false
      t.column     :token, :uuid

      t.timestamps null: false
    end

    execute <<-SQL
      ALTER TABLE invites ALTER token SET DEFAULT uuid_generate_v4();
    SQL

  end
end
