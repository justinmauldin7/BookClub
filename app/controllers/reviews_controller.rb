class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    review = book.reviews.create_review(review_params)
    redirect_to book_path(review.book.id)
  end

  def review_params
    params.require(:review).permit(:title, :rating, :description, :user)
  end
end
