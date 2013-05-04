class Admin::StaffsController < ApplicationController
 
  skip_before_filter :authorize
  before_filter :admin_login
 
  def index
    @staffs = Staff.all
  end

  def new
    @staff = Staff.new
  end

 def create
   @staff = Staff.new(params[:staff])
   if @staff.save
     redirect_to admin_root_path
   else
     flash[:notice] = "Bad value"
     redirect_to new_admin_staff_path
   end
 end

 def destroy
   if Staff.count > 1
     @staff = Staff.find(params[:id])
     @staff.destroy
   else
     flash[:notice] = "Protected staff"
   end
   redirect_to admin_root_path
 end
  
 def admin_login
   redirect_to log_url unless admin_log
 end
  
end
