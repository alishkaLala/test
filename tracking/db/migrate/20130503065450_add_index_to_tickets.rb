class AddIndexToTickets < ActiveRecord::Migration
  def change
     add_index :tickets, :ticket_department_id
  end
end
