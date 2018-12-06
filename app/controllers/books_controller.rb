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

  def create
    book = Book.create_book(book_params)
    redirect_to "/books/#{book.id}"
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :pages, :year)
  end
end
