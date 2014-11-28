class AddFullTextCapabilities < ActiveRecord::Migration
  def up
    unless Rails.env.production?
      enable_extension 'unaccent'
      enable_extension 'citext'
    end

    # Contents search
    add_column :contents, :fulltext, :tsvector

    execute <<-SQL
      DROP TRIGGER IF EXISTS tsvectorupdate ON contents;
      
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON contents FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(fulltext, 'pg_catalog.portuguese', title, body);
    SQL

    # Tags search
    add_column :tags, :fulltext, :tsvector

    execute <<-SQL
      DROP TRIGGER IF EXISTS tsvectorupdate ON tags;

      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON tags FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(fulltext, 'pg_catalog.portuguese', body);
    SQL

    remove_index :tags, :body
    change_column :tags, :body, :citext
    add_index :tags, :body
  end

  def down
    drop_column :contents, :fulltext
    drop_column :tags, :fulltext

    remove_index :tags, :body
    change_column :tags, :body, :text
    add_index :tags, :body
  end

end
