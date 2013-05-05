class TicketsController < ApplicationController
 
  before_filter :redirect_if_login 
  skip_before_filter :authorize

  
  def new
    @ticket = Ticket.new   
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    begin
      @ticket.save!
      rescue Net::SMTPFatalError
        flash.notice = "Can\'t send message to your email, check it and try again"
        return  render :new
      rescue Exception
        return render :new
    end    
    flash.notice = 'Ticket was successfully created.'
    redirect_to root_path
  end

 
  def show_ticket_by_reference
    @ticket = Ticket.find_by_reference(params[:reference])
    @histories = @ticket.ticket_histories
    @comment = Comment.new
    @statuses = TicketStatus.all 
    render "/staff/tickets/show"  
  end
  
  private
    def  redirect_if_login 
      redirect_to staff_root_path if any_log
      redirect_to admin_root_path if admin_log
    end
end
