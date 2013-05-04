class CommentsController < ApplicationController
  skip_before_filter :authorize

  def create
    @comment = Comment.new(params[:comment])
    flash[:notice] = "comment create success" if @comment.save
    redirect_to show_ticket_by_reference_path(@comment.ticket.reference)
  end
  
end
