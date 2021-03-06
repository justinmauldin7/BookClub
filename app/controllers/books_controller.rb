class BooksController < ApplicationController
  def home

  end

  def index
    @books = Book.sort_by(params[:sort])
    @books_top_books = Book.top_books
    @books_bottom_books = Book.bottom_books
    @users_most_reviews = User.most_reviews
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.create_book(book_params)
    redirect_to book_path(book.id)
  end

  def destroy
    Book.destroy(params[:id])
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :pages, :year, :id)
  end
end
