class RenameEmploeeToStaff < ActiveRecord::Migration
  def up
     rename_table :employees, :staffs
  end

  def down
    rename_table :staffs, :employees
  end
end
