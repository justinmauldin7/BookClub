# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
20.times do
  user = Faker::HarryPotter.character
  User.create(username: user)
end

10.times do
  name = Faker::Book.author
  title = Faker::Book.title
  pages = rand(50..2000)
  year = rand(1843..2018)
  author = Author.create(name: name)
  book = Book.create!(title: title, pages: pages, year: year, authors: [author])
  (rand(1..8)).times do
    review_title = Faker::StarWars.quote
    rating = rand(1..5)
    description = Faker::MichaelScott.quote
    Review.create(title: review_title, rating: rating, description: description, user: User.find(rand(User.first.id..User.last.id)), book_id: book.id)
  end
end

10.times do
  name = Faker::FunnyName.three_word_name
  name2 = Faker::FunnyName.three_word_name
  title = Faker::LordOfTheRings.location
  pages = rand(50..2000)
  year = rand(1843..2018)
  author = Author.create(name: name)
  author2 = Author.create(name: name2)
  book = Book.create!(title: title, pages: pages, year: year, authors: [author, author2])
  (rand(1..8)).times do
    review_title = Faker::StarTrek.specie
    rating = rand(1..5)
    description = Faker::MostInterestingManInTheWorld.quote
    Review.create(title: review_title, rating: rating, description: description, user: User.find(rand(User.first.id..User.last.id)), book_id: book.id)
  end
end
