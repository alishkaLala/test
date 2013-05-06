class Staff::TicketsController < ApplicationController
   
   
  def index # only by free or current_staff
    params[:needed_status] = params[:needed_status] ? params[:needed_status] : 1
    @current_staff_id =  any_log
    @tickets = (Ticket.search(params[:needed_status].to_i,params[:needed_template])).where(" staff_id IS  ? OR staff_id = ?", nil, @current_staff_id).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @signed_in = any_log
    @ticket = Ticket.find(params[:id])
    @comments = @ticket.comments.order("created_at DESC").paginate(:per_page => 3, :page => params[:page_comment])
    if (@ticket.staff_id and @ticket.staff_id != @signed_in)
      flash.notice = "Ticket with reference #{@ticket.reference} is owned by another staff (name #{@ticket.staff.name}, id #{@ticket.staff.id})"
      redirect_to staff_tickets_path 
    end  
    @histories = @ticket.ticket_histories.order("created_at DESC").paginate(:per_page => 3, :page => params[:page])
    @current_staff_id =  any_log
   
  end
  
  def update_fields
   
    if params[:body].to_s == ""
      flash.notice = "comment is clear "
      
    else
    
      @notice = "Action by staff: "
      @ticket = Ticket.find(params[:id])
      @person = Staff.find(any_log).name
      
      create_history_and_notice
      begin
        ClientMailer.notify(@ticket, @notice).deliver   
      rescue Net::SMTPFatalError
        flash.notice = "Email was not sent."
      end
    end
    
    redirect_to staff_ticket_path(:id => params[:id])
  end

  def create_history_and_notice
    
    create_comment(params[:body].to_s,params[:id])
    
    update_staff_id(params[:staff_id]) if  @ticket.staff_id.to_s != params[:staff_id].to_s
    update_department(params[:ticket_department_id]) if @ticket.ticket_department_id.to_s != params[:ticket_department_id].to_s
    update_ticket_status_id(params[:ticket_status_id]) if @ticket.ticket_status_id.to_s != params[:ticket_status_id].to_s
 
  end
  
  def create_comment(message,id)
    @comment = Comment.new 
    @comment.body = message
    @comment.ticket_id = id
    @comment.staff_id = any_log
    @notice += "Comment has been created to your request: #{@comment.body}." if @comment.save
  end
  
   
  def update_staff_id(staff_id) 
  
    if @ticket.update_attribute(:staff_id,staff_id)
      owner = @ticket.staff_id.nil? ? "Nobody" : @ticket.staff.name
      @ticket.history_update(@person,'Owner',owner)
      @notice += "Owner of your request has been changed to #{owner}."  
    
    else 
      @notice += 'Can\'t change owner'
    
    end 
     
  end
  
  def update_department(ticket_department)
    
    if @ticket.update_attribute(:ticket_department_id,ticket_department)
      @ticket.history_update(@person,'Ticket department',@ticket.ticket_department.definition)
      @notice += "Department of your request has been changed to #{@ticket.ticket_department.definition}."  
   
    else 
      flash.notice += 'Can\'t change department ' 
   
    end  
  
  end
  
  def update_ticket_status_id(ticket_status_id)
    
    if @ticket.update_attribute(:ticket_status_id,ticket_status_id)
      @ticket.history_update(@person,'Status',@ticket.ticket_status.definition) 
      @notice += "Status of your request has been changed to #{ @ticket.ticket_status.definition }." 
    
    else
      flash.notice += 'Can\'t change status' 
    
    end 
  
  end
  
   
end
