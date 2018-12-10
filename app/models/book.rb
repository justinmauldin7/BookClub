class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  validates :title, uniqueness: true

  has_many :book_authors, :dependent => :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, :dependent => :destroy

  def average_rating
    ave_rating = reviews.average(:rating)
    return ave_rating.round(1) if ave_rating != nil
    ave_rating
  end

  def review_count
    reviews.count
  end

  def self.create_book(params)
    authors = params[:authors].titleize.split(",")
    params[:title] = params[:title].titleize
    params[:authors] = authors.map do |author|
      Author.find_or_create_by(name: author.strip)
    end

    Book.create(params)
  end

  def has_many_authors?
    authors.count > 1
  end
end
