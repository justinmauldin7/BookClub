require 'rails_helper'

describe "as user can see a single book show page" do
  it 'can see book title, author & pages' do

    book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
    book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)

    author_1 = Author.create(name: 'Rock Man')
    author_2 = Author.create(name: 'Rock Woman')
    author_3 = Author.create(name: 'Rock Child')


    rel_1 = BookAuthor.create(book_id: book_1.id, author_id: author_1.id)
    rel_2 = BookAuthor.create(book_id: book_2.id, author_id: author_2.id)
    rel_3 = BookAuthor.create(book_id: book_2.id, author_id: author_3.id)

    user_1 = User.create(username: 'Tod')
    user_2 = User.create(username: 'Tommy')
    user_3 = User.create(username: 'xxTEDxx')
    user_4 = User.create(username: '133t')

    review_1 = Review.create(title: 'This Book Was Gneiss', rating: 5, description: 'Super rad', user_id: user_1.id, book_id: book_1.id)
    review_2 = Review.create(title: 'This Book Was Terrible', rating: 1, description: 'Mega terrible', user_id: user_2.id, book_id: book_1.id)
    review_3 = Review.create(title: 'This Book Was Solid', rating: 5, description: 'Solid', user_id: user_1.id, book_id: book_2.id)
    review_4 = Review.create(title: 'This Book Was Horrible', rating: 1, description: 'Bad Bad Bad', user_id: user_2.id, book_id: book_2.id)
    review_5 = Review.create(title: 'This Book Was Terrific', rating: 4, description: 'Super x99', user_id: user_3.id, book_id: book_2.id)
    review_6 = Review.create(title: 'This Book Was Abyssmal', rating: 2, description: 'Worse than bad', user_id: user_4.id, book_id: book_2.id)

    visit book_path(book_2)

    expect(page).to have_content(book_2.title)
    expect(page).to have_content(author_2.name)
    expect(page).to have_content(author_3.name)
    expect(page).to have_content(book_2.pages)
    expect(page).to have_content(book_2.year)
  end

  it "can see list of all reivews for book" do
    book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
    book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)

    author_1 = Author.create(name: 'Rock Man')
    author_2 = Author.create(name: 'Rock Woman')
    author_3 = Author.create(name: 'Rock Child')


    rel_1 = BookAuthor.create(book_id: book_1.id, author_id: author_1.id)
    rel_2 = BookAuthor.create(book_id: book_2.id, author_id: author_2.id)
    rel_3 = BookAuthor.create(book_id: book_2.id, author_id: author_3.id)

    user_1 = User.create(username: 'Tod')
    user_2 = User.create(username: 'Tommy')
    user_3 = User.create(username: 'xxTEDxx')
    user_4 = User.create(username: '133t')

    review_1 = Review.create(title: 'This Book Was Gneiss', rating: 5, description: 'Super rad', user_id: user_1.id, book_id: book_1.id)
    review_2 = Review.create(title: 'This Book Was Terrible', rating: 1, description: 'Mega terrible', user_id: user_2.id, book_id: book_1.id)
    review_3 = Review.create(title: 'This Book Was Solid', rating: 5, description: 'Solid', user_id: user_1.id, book_id: book_2.id)
    review_4 = Review.create(title: 'This Book Was Horrible', rating: 1, description: 'Bad Bad Bad', user_id: user_2.id, book_id: book_2.id)
    review_5 = Review.create(title: 'This Book Was Terrific', rating: 4, description: 'Super x99', user_id: user_3.id, book_id: book_2.id)
    review_6 = Review.create(title: 'This Book Was Abyssmal', rating: 2, description: 'Worse than bad', user_id: user_4.id, book_id: book_2.id)

    visit book_path(book_2)

    expect(page).to have_no_content(review_1.title)
    expect(page).to have_no_content(review_1.description)

    within "#review-#{review_4.id}" do
      expect(page).to have_no_content(review_3.title)
      expect(page).to have_no_content(review_3.description)
    end

    within "#review-#{review_3.id}" do
      expect(page).to have_content(review_3.title)
      expect(page).to have_content(review_3.rating)
      expect(page).to have_content(review_3.description)
      expect(page).to have_content(review_3.user.username)
    end

    within "#review-#{review_4.id}" do
      expect(page).to have_content(review_4.title)
      expect(page).to have_content(review_4.rating)
      expect(page).to have_content(review_4.description)
      expect(page).to have_content(review_4.user.username)
    end

    within "#review-#{review_5.id}" do
      expect(page).to have_content(review_5.title)
      expect(page).to have_content(review_5.rating)
      expect(page).to have_content(review_5.description)
      expect(page).to have_content(review_5.user.username)
    end

    within "#review-#{review_6.id}" do
      expect(page).to have_content(review_6.title)
      expect(page).to have_content(review_6.rating)
      expect(page).to have_content(review_6.description)
      expect(page).to have_content(review_6.user.username)
    end
  end

  it 'can click to go to add review page' do
    @book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
    @book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)

    @author_1 = Author.create(name: 'Rock Man')
    @author_2 = Author.create(name: 'Rock Woman')

    @rel_1 = BookAuthor.create(book_id: @book_1.id, author_id: @author_1.id)
    @rel_2 = BookAuthor.create(book_id: @book_2.id, author_id: @author_2.id)

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

    visit book_path(@book_1.id)

    click_on 'Add Review'
    expect(current_path).to eq(new_review_path)
  end
end
