class TicketHistory < ActiveRecord::Base
  attr_accessible :action
  validates_presence_of :action
  
  belongs_to :ticket
end
