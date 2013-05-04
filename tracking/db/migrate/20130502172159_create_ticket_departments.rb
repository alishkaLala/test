class CreateTicketDepartments < ActiveRecord::Migration
  def change
    create_table :ticket_departments do |t|
      t.string  :definition
      
      t.timestamps
    end
  end
end
