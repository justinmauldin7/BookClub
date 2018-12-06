class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @book = Book.new
  end

  def create
    review = Review.create_review(review_params)
    binding.pry
    redirect_to book_path(review.book.id)
  end

  def review_params
    params.require(:review).permit(:title, :rating, :description, :user)
  end
end
