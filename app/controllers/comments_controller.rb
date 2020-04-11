class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.board_id = current_user.id
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])
    comment.delete
    flash[:notice] = "コメントが削除されました"
    redirect_to comment.board
  end
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end