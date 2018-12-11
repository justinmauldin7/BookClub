# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'pry'
# books, authors, users, reviews
20.times do
  user = Faker::HarryPotter.character
  User.create(username: user)
end

40.times do
  name = Faker::Book.author
  title = Faker::Book.title
  pages = rand(50..2000)
  year = rand(1843..2018)
  author = Author.create(name: name)
  book = Book.create!(title: title, pages: pages, year: year, authors: [author])
  4.times do
    review_title = Faker::StarWars.quote
    rating = rand(1..5)
    description = Faker::MichaelScott.quote
    Review.create(title: review_title, rating: rating, description: description, user: User.find(rand(User.first.id..User.last.id)), book_id: book.id)
  end
end
