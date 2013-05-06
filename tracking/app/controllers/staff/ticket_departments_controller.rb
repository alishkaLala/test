class Staff::TicketDepartmentsController < ApplicationController
  require 'will_paginate/array' 
  def index
    @ticket_departments = TicketDepartment.all.paginate(:page => params[:page], :per_page => 10)
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
    if TicketDepartment.count < 2
      flash[:notice] = "You can not remove a single department" 
    
    else
      @ticket_department = TicketDepartment.find(params[:id])
      begin
        @ticket_department.destroy
      rescue  Exception
        flash[:notice] = "Department in use" 
      end
    
    end
    redirect_to staff_ticket_departments_path 
  end
  
  
end
