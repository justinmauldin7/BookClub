require 'rails_helper'

describe 'visiting an author page' do
  describe 'as a user' do
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
      @user_3 = User.create(username: 'xxTEDxx')
      @user_4 = User.create(username: '133t')

      @review_1 = Review.create(title: 'This Book Was Gneiss', rating: 5, description: 'Super rad', user_id: @user_1.id, book_id: @book_1.id)
      @review_2 = Review.create(title: 'This Book Was Terrible', rating: 1, description: 'Mega terrible', user_id: @user_2.id, book_id: @book_1.id)
      @review_3 = Review.create(title: 'This Book Was Solid', rating: 5, description: 'Solid', user_id: @user_1.id, book_id: @book_2.id)
      @review_4 = Review.create(title: 'This Book Was Horrible', rating: 1, description: 'Bad Bad Bad', user_id: @user_2.id, book_id: @book_2.id)
      @review_5 = Review.create(title: 'This Book Was Terrific', rating: 4, description: 'Super x99', user_id: @user_3.id, book_id: @book_2.id)
      @review_6 = Review.create(title: 'This Book Was Abyssmal', rating: 2, description: 'Worse than bad', user_id: @user_4.id, book_id: @book_2.id)
    end

    it 'can see a list of books from author' do
      visit author_path(@author_2.id)
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_1.year)
      expect(page).to have_content(@book_1.pages)
      expect(page).to have_content(@book_2.title)
      expect(page).to have_no_content(@book_3.title)
    end

    it 'can click on book titles to go to book show page' do
      visit author_path(@author_2.id)
      click_on @book_1.title
      expect(current_path).to eq(book_path(@book_1.id))

      visit author_path(@author_2.id)
      click_on @book_2.title
      expect(current_path).to eq(book_path(@book_2.id))
    end
  end
end
