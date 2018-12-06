class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def average_rating
    reviews.average(:rating)
  end

  def review_count
    reviews.count
  end

  def self.create_book(params)
    authors = params[:authors].titleize.split(",")
    params[:authors] = authors.map do |author|
      Author.find_or_create_by(name: author.strip)
    end

    Book.create(params)
  end
end
