require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_inclusion_of(:rating).in_array([1,2,3,4,5]) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe 'class methods' do
    it 'can create a new review' do

      book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
      params = {title: "this sucks", description: "WORST BOOK EVER!!!!", user: "TODDD", rating: 1, book_id: book_1.id}

      User.create(username: "TODDD")

      review_1 = Review.create_review(params)

      expect(review_1).to eq(Review.last)
    end
  end
end
