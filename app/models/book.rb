class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def self.average_rating(book_id)
    Review.where("book_id = #{book_id}".average(:rating))
  end
end
