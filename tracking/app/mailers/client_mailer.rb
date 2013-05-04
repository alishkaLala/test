class ClientMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def new_ticket_created(ticket)
    @ticket = ticket
    @link = show_ticket_by_reference_url(@ticket.reference)
    mail(:to => @ticket.email, :subject => "New query was posted")
    
  end
   
  def notify(ticket, message)
    @message = message
    @ticket = ticket
    @link = show_ticket_by_reference_url(@ticket.reference)
    mail(:to => @ticket.email, :subject => "New action")
  end
  
end
