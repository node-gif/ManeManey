class BoardsController < ApplicationController
  def index
    @board = Board.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
