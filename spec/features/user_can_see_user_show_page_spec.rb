require 'rails_helper'

describe 'as a user on the user show page' do
  before(:each) do
    @book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
    @book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)
    @book_3 = Book.create(title:'How To Sew', pages: 7, year: 2014)

    @author_1 = Author.create(name: 'Rock Man')
    @author_2 = Author.create(name: 'Rock Woman')

    @rel_1 = BookAuthor.create(book_id: @book_1.id, author_id: @author_1.id)
    @rel_3 = BookAuthor.create(book_id: @book_1.id, author_id: @author_2.id)
    @rel_2 = BookAuthor.create(book_id: @book_2.id, author_id: @author_2.id)

    @user_1 = User.create(username: 'Tod')
    @user_2 = User.create(username: 'Tommy')
    @user_3 = User.create(username: 'Teddy')
    @user_4 = User.create(username: '133t')

    @review_1 = Review.create(title: 'This Book Was Gneiss', rating: 5, description: 'Super rad', user_id: @user_1.id, book_id: @book_1.id)
    @review_2 = Review.create(title: 'This Book Was Terrible', rating: 1, description: 'Mega terrible', user_id: @user_2.id, book_id: @book_1.id)
    @review_3 = Review.create(title: 'This Book Was Solid', rating: 5, description: 'Solid', user_id: @user_1.id, book_id: @book_2.id)
    @review_4 = Review.create(title: 'This Book Was Horrible', rating: 1, description: 'Bad Bad Bad', user_id: @user_2.id, book_id: @book_2.id)
    @review_5 = Review.create(title: 'This Book Was Terrific', rating: 4, description: 'Super x99', user_id: @user_3.id, book_id: @book_2.id)
    @review_6 = Review.create(title: 'This Book Was Abyssmal', rating: 2, description: 'Worse than bad', user_id: @user_4.id, book_id: @book_2.id)
  end

  it 'can see all reviews by a user including title rating and description' do
    visit user_path(@user_1.id)

    expect(page).to have_content(@user_1.username)

    within("#review-#{@review_1.id}") do
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content("Rating: #{@review_1.rating}")
      expect(page).to have_content(@review_1.description)
    end

    within("#review-#{@review_3.id}") do
      expect(page).to have_content(@review_3.title)
      expect(page).to have_content("Rating: #{@review_3.rating}")
      expect(page).to have_content(@review_3.description)
    end
  end

  it 'can see the title of book in review' do
    visit user_path(@user_1.id)

    within("#review-#{@review_1.id}") do
      expect(page).to have_content(@review_1.book.title)
    end
  end

  it 'can sort reviews by newest or oldest first' do
    visit user_path(@user_1.id)

    click_on 'Sort by newest first'
    expect(all('.review')[0]).to have_content(@review_3.title)
    expect(all('.review')[1]).to have_content(@review_1.title)

    click_on 'Sort by oldest first'
    expect(all('.review')[0]).to have_content(@review_1.title)
    expect(all('.review')[1]).to have_content(@review_3.title)
  end
end
