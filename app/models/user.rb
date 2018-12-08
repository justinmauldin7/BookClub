class User < ApplicationRecord
  validates_presence_of :username
  validates :username, uniqueness: true
  has_many :reviews, :dependent => :destroy

  def sorted_reviews(sort_method)
    if sort_method == 'oldest_first'
      return reviews.order(created_at: :asc)
    else
      return reviews.order(created_at: :desc)
    end
  end
end
