class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def average_rating(book_id)
    Book.find(book_id).reviews.average(:rating)
  end
end
