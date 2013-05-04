class CreateTicketHistories < ActiveRecord::Migration
  def change
    create_table :ticket_histories do |t|
      t.string :action
      
      t.references :ticket
      t.timestamps
    end
    add_index :ticket_histories, :ticket_id
  end
end
