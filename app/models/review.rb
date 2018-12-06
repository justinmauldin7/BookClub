class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def self.create_review(params)
    binding.pry
    params[:user] = params[:user].titleize
    params[:title] = params[:title].titleize
    params[:book] = Book.find(params[:book_id])
    params[:user] = User.find_or_create_by(username: params[:user])
    Review.create!(params)
  end

end
