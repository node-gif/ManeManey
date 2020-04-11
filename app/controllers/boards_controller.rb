class BoardsController < ApplicationController
  before_action :authenticate_user!, only: %i[show new create edit update destroy]
  before_action :set_target_board, only: %i[show edit update destroy]
  
  def index
    @board = Board.page(params[:page]).order(created_at: :desc)
  end

  def show
    @comment = Comment.new(board_id: @board.id)
    @comments = Comment.all
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
  end
  
  def update
    @board.update(board_params)
    if @board.save
      flash[:notice] = "「#{ @board.title }」を更新しました"
      redirect_to @board
    else
      render :edit
    end
  end
  
  def destroy
    @board.delete
    flash[:alert] = "投稿を削除しました"
    redirect_to boards_path
  end
  
  private
  
    def board_params
      params.require(:board).permit(:title, :body).merge(user_id: current_user.id)
    end
    
    def set_target_board
      @board = Board.find_by(id: params[:id])
    end
end
