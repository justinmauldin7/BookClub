class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates_inclusion_of :rating, in: [1,2,3,4,5]

  def self.create_review(params)
    params[:user] = params[:user].titleize
    params[:title] = params[:title].titleize
    params[:user] = User.find_or_create_by(username: params[:user])
    Review.create(params)
  end



end
