class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      
      t.references :employee
      t.references :ticket
      t.timestamps
    end
    
    add_index :comments, :employee_id
    add_index :comments, :ticket_id
  end
end
