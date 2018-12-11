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
    it { should have_many(:reviews) }
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

    it 'can return count of reviews' do
      count_review = @book_1.review_count

      expect(count_review).to eq(2)
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

    it "can find average rating for a book" do
      average_rating = 3.0
      book_2 = @book_2.average_rating

      expect(book_2).to eq(average_rating)
    end
  end

  describe 'class methods' do
    before(:each) do
      @book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
      @book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)
      @book_3 = Book.create(title:'How To Sew', pages: 7, year: 2014)
      @book_4 = Book.create(title:'How To Sew 2', pages: 9, year: 2014)

      @author_1 = Author.create(name: 'Rock Man')
      @author_2 = Author.create(name: 'Rock Woman')
      @author_3 = Author.create(name: 'Rock Child')

      @rel_1 = BookAuthor.create(book_id: @book_1.id, author_id: @author_1.id)
      @rel_3 = BookAuthor.create(book_id: @book_1.id, author_id: @author_2.id)
      @rel_2 = BookAuthor.create(book_id: @book_2.id, author_id: @author_2.id)
      @rel_4 = BookAuthor.create(book_id: @book_3.id, author_id: @author_2.id)
      @rel_5 = BookAuthor.create(book_id: @book_4.id, author_id: @author_1.id)
      @rel_6 = BookAuthor.create(book_id: @book_2.id, author_id: @author_3.id)

      @user_1 = User.create(username: 'Tod')
      @user_2 = User.create(username: 'Tommy')
      @user_3 = User.create(username: 'xxTEDxx')
      @user_4 = User.create(username: '133t')

      @review_1 = Review.create(title: 'This Book Was Gneiss', rating: 3, description: 'Super rad', user_id: @user_1.id, book_id: @book_1.id)
      @review_2 = Review.create(title: 'This Book Was Terrible', rating: 1, description: 'Mega terrible', user_id: @user_2.id, book_id: @book_1.id)
      @review_3 = Review.create(title: 'This Book Was Solid', rating: 5, description: 'Solid', user_id: @user_1.id, book_id: @book_2.id)
      @review_4 = Review.create(title: 'This Book Was Horrible', rating: 1, description: 'Bad Bad Bad', user_id: @user_2.id, book_id: @book_2.id)
      @review_5 = Review.create(title: 'This Book Was Terrific', rating: 4, description: 'Super x99', user_id: @user_3.id, book_id: @book_2.id)
      @review_6 = Review.create(title: 'This Book Was Abyssmal', rating: 2, description: 'Worse than bad', user_id: @user_4.id, book_id: @book_2.id)
      @review_7 = Review.create(title: 'This Book Was Barely Abyssmal', rating: 4, description: 'Worse than bad', user_id: @user_4.id, book_id: @book_3.id)
    end

    it 'can create a new book' do
      book_1 = Book.create_book({title:'How To mine', pages: 50, year: 1935, authors: "Billy Bob"})

      expect(book_1).to eq(Book.last)
    end

    it "can find bottom 3 books by rating" do
      @review_8 = Review.create(title: 'This Book Was awesome!', rating: 4, description: 'Worse than terrible', user_id: @user_1.id, book_id: @book_3.id)
      @review_9 = Review.create(title: 'This Book Was Barely readible', rating: 1, description: 'Worse than worse', user_id: @user_4.id, book_id: @book_3.id)
      @review_10 = Review.create(title: 'This Book Was horrid', rating: 1, description: 'Worse than badddd', user_id: @user_4.id, book_id: @book_3.id)

      bottom_books = Book.bottom_books

      expect(bottom_books).to eq([@book_4, @book_1, @book_3])
    end

    it "can find top 3 books by rating" do
      @review_8 = Review.create(title: 'This Book Was awesome!', rating: 4, description: 'Worse than terrible', user_id: @user_1.id, book_id: @book_3.id)
      @review_9 = Review.create(title: 'This Book Was Barely readible', rating: 1, description: 'Worse than worse', user_id: @user_4.id, book_id: @book_3.id)
      @review_10 = Review.create(title: 'This Book Was horrid', rating: 1, description: 'Worse than badddd', user_id: @user_4.id, book_id: @book_3.id)

      top_books = Book.top_books

      expect(top_books).to eq([@book_2, @book_3, @book_1])
    end

    it "can sort books by review raiting, page count & user with most reviews" do
      sort_1 = Book.sort_by("arhtl")
      sort_2 = Book.sort_by("arlth")
      sort_3 = Book.sort_by("noplth")
      sort_4 = Book.sort_by("nophtl")
      sort_5 = Book.sort_by("norltm")
      sort_6 = Book.sort_by("normtl")

      expect(sort_1).to eq([@book_3, @book_2, @book_1, @book_4])
      expect(sort_2).to eq([@book_4, @book_1, @book_2, @book_3])
      expect(sort_3).to eq([@book_1, @book_3, @book_4, @book_2])
      expect(sort_4).to eq([@book_2, @book_4, @book_3, @book_1])
      expect(sort_5).to eq([@book_4, @book_3, @book_1, @book_2])
      expect(sort_6).to eq([@book_2, @book_1, @book_3, @book_4])
    end
  end
end
