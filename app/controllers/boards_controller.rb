class BoardsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @board = Board.all.order(created_at: :desc)
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
      flash[:alert] = "投稿に失敗しました"
      render new_board_path
    end
  end

  def edit
  end
  
  private
  
    def board_params
      params.require(:board).permit(:title, :body).merge(user_id: current_user.id)
    end
end
