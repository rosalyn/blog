class DropTags < ActiveRecord::Migration
  def up
    drop_table :tags
  end

  def down
    create_table :tags do |t|
      t.string :name
      t.references :article

      t.timestamps        
    end
    add_index :tags, :articles
  end
  def change
  end
end
