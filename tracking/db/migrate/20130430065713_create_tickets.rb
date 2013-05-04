class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string      :name 
      t.string      :email  
      t.string      :subject
      t.text        :body
      
      t.string      :reference 
      
      t.references  :employee
      t.references  :ticket_status
      t.references  :ticket_department
      t.timestamps
      
    end
    
    add_index :tickets, :ticket_status_id
    add_index :tickets, :employee_id
    
  end
end

