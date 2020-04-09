class BoardsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @board = Board.page(params[:page]).order(created_at: :desc)
  end

  def show
    @board = Board.find_by(id: params[:id])
    @user = User.find_by(id: @board.user_id)
  end

  def new
    @board = Board.new
  end
  
  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:notice] = "投稿に成功しました"
      redirect_to @board
    else
      render new_board_path
    end
  end

  def edit
    @board = Board.find_by(id: params[:id])
  end
  
  def update
    @board = Board.find_by(id: params[:id])
    @board.update(board_params)
    if @board.save
      flash[:notice] = "「#{ @board.title }」を更新しました"
      redirect_to @board
    else
      render :edit
    end
  end
  
  def destroy
    board = Board.find_by(id: params[:id])
    board.delete
    flash[:alert] = "投稿を削除しました"
    redirect_to boards_path
  end
  
  private
  
    def board_params
      params.require(:board).permit(:title, :body).merge(user_id: current_user.id)
    end
end
