class Ticket < ActiveRecord::Base
  attr_accessible :name, :email, :name,
                  :subject, :body, :ticket_department_id
  
  belongs_to  :ticket_status
  belongs_to  :ticket_department
  belongs_to  :staff
  has_many    :comments
  has_many    :ticket_histories
  
              
  validates :name, :email, :subject, :body,
            :ticket_department_id, :ticket_status_id, :reference, :presence => true
   

  before_validation(:on => :create) do
    self.ticket_status_id = 1
    set_reference
  end
  
  
  
  after_create  :client_notify, :history_creation
  
  
  def self.search owner,needed_status=1, needed_template=nil # only by free or current_staff
    @current_staff_id = owner
    needed_template.to_s == "" ? (self.seach_by_ticket_status(needed_status)) : self.seach_by_template(needed_template)
  end
  
  def self.seach_by_ticket_status needed_status
    case needed_status 
      when 1 #unassigned tickets (status = unassigned)
        Ticket.where("ticket_status_id = 1").where(:staff_id => [nil,@current_staff_id])
      when 2 #open ticket = not close (close = complated or canseled)
        Ticket.where("ticket_status_id NOT IN (4,5)").where(:staff_id => [nil,@current_staff_id])
      when 3 #on hold tickets
        Ticket.where("ticket_status_id = 3").where(:staff_id => [nil,@current_staff_id])
      when 4 #close tickets
        Ticket.where("ticket_status_id IN (4,5)").where(:staff_id => [nil,@current_staff_id])
      else #all ticket 
        Ticket.where(:staff_id => [nil,@current_staff_id])
      end      
  end
  
  def self.seach_by_template template
    where("reference LIKE ? or subject LIKE ?","%#{template}%","%#{template}%")  
  end
    
    def history_creation
      ticket_histories.build(:action => "#{ self.name } created a query" ).save
    end
    
    
    def history_update person, type, value
       sentence = "#{person} : #{type} was changed to #{value} "
       ticket_histories.build(:action => sentence).save
    end
    
    def client_notify
      ClientMailer.new_ticket_created(self).deliver
    end
    
    def set_reference
      ref = gen_reference
      if Ticket.find_by_reference ref
        set_reference
      else
        self.reference = ref 
      end
    end
      
    def gen_reference
      letter = (1..3).map{ (rand(26) + "A".ord).chr }.join
      number = (1..6).map{ (rand(10) + "0".ord).chr }.join
      "#{ letter }-#{ number }"
    end
    
  
end
