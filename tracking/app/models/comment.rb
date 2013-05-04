class Comment < ActiveRecord::Base
  attr_accessible :body, :staff_id, :ticket_id
  
  belongs_to :ticket
  belongs_to :staff
  
  validates :body, :ticket_id, presence: true

end
