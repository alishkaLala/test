class Staff::TicketDepartmentsController < ApplicationController
 
  def index
    @ticket_departments = TicketDepartment.all
  end

  def create
    @ticket_department = TicketDepartment.new(params[:ticket_department])
   
    if @ticket_department.save
      flash[:notice] = "Saved department"
    else  
      flash[:notice] = "Wrong definition of department" 
    end
    
    redirect_to staff_ticket_departments_path
   
  end

  def destroy
    @ticket_department = TicketDepartment.find(params[:id])
    begin
      @ticket_department.destroy
    rescue  Exception
      flash[:notice] = "Department in use" 
    end
    redirect_to staff_ticket_departments_path 
  end
  
  
end
