class Book < ApplicationRecord
  validates_presence_of :title, :pages, :year
  validates :title, uniqueness: true

  has_many :book_authors, :dependent => :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, :dependent => :destroy

  def self.sort_by(sort_method)
    binding.pry
    case sort_method
    when nil
      return all
    when "arhtl"
      
    when "nophtl"
      return order(pages: :desc)
    when "noplth"
      return order(pages: :asc)
    else
      return all

    end
  end

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

  def top_review
    reviews.order(rating: :desc).first
  end

  def has_reviews?
    reviews.count > 0
  end

  def top_reviews
    top = reviews.order(rating: :desc)
    if top.count < 3
      return top
    else
      return top[0..2]
    end
  end

  def bottom_reviews
    bottom = reviews.order(rating: :asc)
    if bottom.count < 3
      return bottom
    else
      return bottom[0..2]
    end
  end
end
