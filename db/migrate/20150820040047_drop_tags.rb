class DropTags < ActiveRecord::Migration
  def up
    drop_table :tablename
  end

  def down
    create_table :tablename do |t|
      t.string :table_column
      t.references :anothertable

      t.timestamps        
    end
    add_index :tablenames, :anothertable_id
  end
  def change
  end
end
