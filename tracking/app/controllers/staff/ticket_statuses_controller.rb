class Staff::TicketStatusesController < ApplicationController
  require 'will_paginate/array'  
  def index
    @ticket_statuses = TicketStatus.all.paginate(:page => params[:page], :per_page => 10)
  end

  def create
    @ticket_status = TicketStatus.new(params[:ticket_status])
    
    if @ticket_status.save
      flash[:notice] = "Saved!"
    else  
      flash[:notice] = "Wrong definition!" 
    end
    redirect_to staff_ticket_statuses_path
  end

  def destroy
    if (params[:id].to_i < 6)
      flash[:notice] = "Protected Status"
    else  
      @ticket_status = TicketStatus.find(params[:id])
      begin
        @ticket_status.destroy
      rescue  Exception
        flash[:notice] = "Status in use" 
      end
    end
    redirect_to staff_ticket_statuses_path 
  end
 
end
