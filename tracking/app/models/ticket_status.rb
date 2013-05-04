class TicketStatus < ActiveRecord::Base
  attr_accessible :definition
  
  validates_uniqueness_of :definition
  validates_presence_of   :definition
  
  has_many :ticket,  dependent: :restrict
end
