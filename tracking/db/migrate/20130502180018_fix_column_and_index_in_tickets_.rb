class FixColumnAndIndexInTickets < ActiveRecord::Migration
  def up
    rename_column :tickets, :employee_id, :staff_id
    remove_index :tickets, :employee_id
    add_index :tickets, :staff_id
  end

  def down
    rename_column :tickets,  :staff_id, :employee_id
    add_index :tickets, :employee_id
    remove_index :tickets, :staff_id
  end
end
