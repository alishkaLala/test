class FixColumnName < ActiveRecord::Migration
  def up
     rename_column :comments, :employee_id, :staff_id
     remove_index :comments, :employee_id
     add_index :comments, :staff_id
  end

  def down
    rename_column :comments,  :staff_id, :employee_id
    add_index :comments, :employee_id
    remove_index :comments, :staff_id
  end
end
