require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:pages) }
    it { should validate_presence_of(:year) }
    it { should validate_uniqueness_of(:title) }
  end

  describe 'relationships' do
    it { should have_many(:book_authors) }
    it { should have_many(:authors).through(:book_authors) }
  end

  describe 'instance methods' do
    before(:each) do
      @book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
      @book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)
      @book_3 = Book.create(title:'How To Sew', pages: 7, year: 2014)

      @author_1 = Author.create(name: 'Rock Man')
      @author_2 = Author.create(name: 'Rock Woman')

      @rel_1 = BookAuthor.create(book_id: @book_1.id, author_id: @author_1.id)
      @rel_3 = BookAuthor.create(book_id: @book_1.id, author_id: @author_2.id)
      @rel_2 = BookAuthor.create(book_id: @book_2.id, author_id: @author_2.id)
      @rel_4 = BookAuthor.create(book_id: @book_3.id, author_id: @author_2.id)

      @user_1 = User.create(username: 'Tod')
      @user_2 = User.create(username: 'Tommy')
      @user_3 = User.create(username: 'xxTEDxx')
      @user_4 = User.create(username: '133t')

      @review_1 = Review.create(title: 'This Book Was Gneiss', rating: 5, description: 'Super rad', user_id: @user_1.id, book_id: @book_1.id)
      @review_2 = Review.create(title: 'This Book Was Terrible', rating: 1, description: 'Mega terrible', user_id: @user_2.id, book_id: @book_1.id)
      @review_3 = Review.create(title: 'This Book Was Solid', rating: 5, description: 'Solid', user_id: @user_1.id, book_id: @book_2.id)
      @review_4 = Review.create(title: 'This Book Was Horrible', rating: 1, description: 'Bad Bad Bad', user_id: @user_2.id, book_id: @book_2.id)
      @review_5 = Review.create(title: 'This Book Was Terrific', rating: 4, description: 'Super x99', user_id: @user_3.id, book_id: @book_2.id)
      @review_6 = Review.create(title: 'This Book Was Abyssmal', rating: 2, description: 'Worse than bad', user_id: @user_4.id, book_id: @book_2.id)
    end

    it 'can return whether there are additional authors' do
      book_1 = @book_1.has_many_authors?
      book_2 = @book_2.has_many_authors?

      expect(book_1).to eq(true)
      expect(book_2).to eq(false)
    end

    it 'can return the top review of a book' do
      top_review = @book_1.top_review

      expect(top_review).to eq(@review_1)
    end

    it 'can return whether it has any reviews' do
      has_reviews_1 = @book_1.has_reviews?
      has_reviews_3 = @book_3.has_reviews?

      expect(has_reviews_1).to eq(true)
      expect(has_reviews_3).to eq(false)
    end

    it 'can return top and bottom 3 reviews for a book' do
      top_3 = [@review_3, @review_5, @review_6]
      bottom_3 = [@review_4, @review_6, @review_5]

      expect(@book_2.top_reviews).to eq(top_3)
      expect(@book_2.bottom_reviews).to eq(bottom_3)
    end

    it 'will return 0 or top or bottom reviews if less than 3 exist' do
      top_reviews = [@review_1, @review_2]
      bottom_reviews = [@review_2, @review_1]
      no_reviews = []

      expect(@book_1.top_reviews).to eq(top_reviews)
      expect(@book_1.bottom_reviews).to eq(bottom_reviews)

      expect(@book_3.top_reviews).to eq(no_reviews)
      expect(@book_3.bottom_reviews).to eq(no_reviews)
    end
  end

  describe 'class methods' do
    xit "can find average rating for a book" do
      @author_1 = Author.create(name: 'Rock Man')
      @author_2 = Author.create(name: 'Rock Woman')

      @book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934, authors: [@author_1, @author_2])
      @book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895, authors: [@author_2])

      @user_1 = User.create(username: 'Tod')
      @user_2 = User.create(username: 'Tommy')
      @user_3 = User.create(username: 'xxTEDxx')
      @user_4 = User.create(username: '133t')

      @review_1 = Review.create(title: 'This Book Was Gneiss', rating: 5, description: 'Super rad', user_id: @user_1.id, book_id: @book_1.id)
      @review_2 = Review.create(title: 'This Book Was Terrible', rating: 1, description: 'Mega terrible', user_id: @user_2.id, book_id: @book_1.id)
      @review_3 = Review.create(title: 'This Book Was Solid', rating: 5, description: 'Solid', user_id: @user_1.id, book_id: @book_2.id)
      @review_4 = Review.create(title: 'This Book Was Horrible', rating: 1, description: 'Bad Bad Bad', user_id: @user_2.id, book_id: @book_2.id)
      @review_5 = Review.create(title: 'This Book Was Terrific', rating: 4, description: 'Super x99', user_id: @user_3.id, book_id: @book_2.id)
      @review_6 = Review.create(title: 'This Book Was Abyssmal', rating: 2, description: 'Worse than bad', user_id: @user_4.id, book_id: @book_2.id)


      average_rating = 3.0
      book_2 = @book_2.average_rating

      expect(book_2).to eq(average_rating)
    end
  end
end
