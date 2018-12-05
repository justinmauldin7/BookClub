class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end

  def new
    @book = Book.new
  end
end
