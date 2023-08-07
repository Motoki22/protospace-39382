class CommentsController < ApplicationController
before_action :set_prototype, only: [:create,:show]

  def create
    @comment = @prototype.comments.new(comment_params) 
    if @comment.save
      redirect_to @prototype
    else
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show" 
    end
  end

  def show
    @comment = Comment.new
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end
  
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

  
end
