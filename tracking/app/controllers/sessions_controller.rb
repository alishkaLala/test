class SessionsController < ApplicationController
  skip_before_filter :authorize

  def create
    staff = Staff.find_by_login(params[:login])
    admin = Admin.find_by_login(params[:login])
    if staff and staff.authenticate(params[:pasword])
      session[:staff_id] = staff.id
      redirect_to staff_root_path, notice: "Welcome"
    elsif admin and admin.authenticate(params[:pasword])
      session[:admin_id] = admin.id
      redirect_to admin_root_path
    else 
      redirect_to log_url, alert: "Bad combination"
    end
  end

  def destroy
    session[:admin_id] = nil
    session[:staff_id] = nil
    redirect_to root_url, notice: "Seans over"
  end
  
  
end
