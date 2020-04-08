class BoardsController < ApplicationController
  def index
    @board = Board.all
  end

  def show
    @board = Board.find_by(params[:id])
  end

  def new
    @board = Board.new
  end

  def edit
  end
  
  private
  
    def board_params
      params.require(:board).permit(:title, :body)
    end
end
