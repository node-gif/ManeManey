class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to @board
    else
      render :@board
    end
  end

  def destroy
  end
  
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :board_id)
  end
end
