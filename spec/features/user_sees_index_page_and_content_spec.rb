require 'rails_helper'

describe 'book_index' do
  describe 'as a user' do
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

    it 'can see all books' do
      visit books_path

      within "#book-#{@book_1.id}" do
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content("Pages: #{@book_1.pages}")
        expect(page).to have_content("Year: #{@book_1.year}")
      end
      within "#book-#{@book_2.id}" do
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content("Pages: #{@book_2.pages}")
        expect(page).to have_content("Year: #{@book_2.year}")
      end
      within "#book-#{@book_3.id}" do
        expect(page).to have_content(@book_3.title)
        expect(page).to have_content("Pages: #{@book_3.pages}")
        expect(page).to have_content("Year: #{@book_3.year}")
      end
    end

    it 'can see authors' do
      visit books_path

      within "#book-#{@book_1.id}" do
        expect(page).to have_content(@author_1.name)
      end
      within "#book-#{@book_2.id}" do
        expect(page).to have_content(@author_2.name)
        expect(page).to have_content(@author_3.name)
      end
    end

    it 'can see average rating of book and total number of reviews' do
      visit books_path

      within "#book-#{@book_1.id}" do
        expect(page).to have_content('Average rating: 2')
        expect(page).to have_content('Total reviews: 2')
      end

      within "#book-#{@book_2.id}" do
        expect(page).to have_content('Average rating: 3')
        expect(page).to have_content('Total reviews: 4')
      end
    end

    it 'can sort by rating, pages, or reviews' do
      visit books_path

      click_on 'Average rating high to low'
      expect(all('.book')[0]).to have_content(@book_3.title)
      expect(all('.book')[1]).to have_content(@book_2.title)
      expect(all('.book')[2]).to have_content(@book_1.title)
      expect(all('.book')[3]).to have_content(@book_4.title)

      click_on 'Average rating low to high'
      expect(all('.book')[0]).to have_content(@book_4.title)
      expect(all('.book')[1]).to have_content(@book_1.title)
      expect(all('.book')[2]).to have_content(@book_2.title)
      expect(all('.book')[3]).to have_content(@book_3.title)

      click_on 'Number of pages low to high'
      expect(all('.book')[0]).to have_content(@book_1.title)
      expect(all('.book')[1]).to have_content(@book_3.title)
      expect(all('.book')[2]).to have_content(@book_4.title)
      expect(all('.book')[3]).to have_content(@book_2.title)

      click_on 'Number of pages high to low'
      expect(all('.book')[0]).to have_content(@book_2.title)
      expect(all('.book')[1]).to have_content(@book_4.title)
      expect(all('.book')[2]).to have_content(@book_3.title)
      expect(all('.book')[3]).to have_content(@book_1.title)

      click_on 'Number of reviews least to most'
      expect(all('.book')[0]).to have_content(@book_4.title)
      expect(all('.book')[1]).to have_content(@book_3.title)
      expect(all('.book')[2]).to have_content(@book_1.title)
      expect(all('.book')[3]).to have_content(@book_2.title)

      click_on 'Number of reviews most to least'
      expect(all('.book')[0]).to have_content(@book_2.title)
      expect(all('.book')[1]).to have_content(@book_1.title)
      expect(all('.book')[2]).to have_content(@book_3.title)
      expect(all('.book')[3]).to have_content(@book_4.title)
    end

    it 'shows 3 top & 3 bottom books, as well as, 3 users with most reviews' do
      @review_8 = Review.create(title: 'This Book Was awesome!', rating: 4, description: 'Worse than terrible', user_id: @user_1.id, book_id: @book_3.id)
      @review_9 = Review.create(title: 'This Book Was Barely readible', rating: 1, description: 'Worse than worse', user_id: @user_4.id, book_id: @book_3.id)
      @review_10 = Review.create(title: 'This Book Was horrid', rating: 1, description: 'Worse than badddd', user_id: @user_4.id, book_id: @book_3.id)

      visit books_path

      expect(all('.top-3-books')[0]).to have_content(@book_2.title)
      expect(all('.top-3-books')[1]).to have_content(@book_3.title)
      expect(all('.top-3-books')[2]).to have_content(@book_1.title)

      expect(all('.bottom-3-books')[0]).to have_content(@book_4.title)
      expect(all('.bottom-3-books')[1]).to have_content(@book_1.title)
      expect(all('.bottom-3-books')[2]).to have_content(@book_3.title)

      expect(all('.most-reviews')[0]).to have_content(@user_4.username)
      expect(all('.most-reviews')[1]).to have_content(@user_1.username)
      expect(all('.most-reviews')[2]).to have_content(@user_2.username)
    end
  end
end
