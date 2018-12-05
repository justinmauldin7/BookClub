class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def average_rating(book_id)
    Book.where("id = #{book_id}").first.reviews.average(:rating)
  end
end
