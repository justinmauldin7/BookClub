require 'rails_helper'

describe 'user_index' do
  describe 'as a user' do
    it 'can see all books' do
      book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
      book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)
      book_3 = Book.create(title:'How To Test Tests', pages: 64, year: 2018)

      visit '/books'

      within "#book-#{book_1.id}" do
        expect(page).to have_content(book_1.title)
        expect(page).to have_content("Pages: #{book_1.pages}")
        expect(page).to have_content("Year: #{book_1.year}")
      end
      within "#book-#{book_2.id}" do
        expect(page).to have_content(book_2.title)
        expect(page).to have_content("Pages: #{book_2.pages}")
        expect(page).to have_content("Year: #{book_2.year}")
      end
      within "#book-#{book_3.id}" do
        expect(page).to have_content(book_3.title)
        expect(page).to have_content("Pages: #{book_3.pages}")
        expect(page).to have_content("Year: #{book_3.year}")
      end
    end

    it 'can see authors' do
      book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
      book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)

      author_1 = Author.create(name: 'Rock Man')
      author_2 = Author.create(name: 'Rock Woman')

      rel_1 = BookAuthor.create(book_id: book_1.id, author_id: author_1.id)
      rel_2 = BookAuthor.create(book_id: book_2.id, author_id: author_2.id)

      visit '/books'
      within "#book-#{book_1.id}" do
        expect(page).to have_content(author_1.name)
      end
      within "#book-#{book_2.id}" do
        expect(page).to have_content(author_2.name)
      end
    end

    it 'can see average rating of book and total number of reviews' do
      book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
      book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)

      author_1 = Author.create(name: 'Rock Man')
      author_2 = Author.create(name: 'Rock Woman')

      rel_1 = BookAuthor.create(book_id: book_1.id, author_id: author_1.id)
      rel_2 = BookAuthor.create(book_id: book_2.id, author_id: author_2.id)

      user_1 = User.create(username: 'Tod')
      user_2 = User.create(username: 'Tommy')
      user_3 = User.create(username: 'xxTEDxx')
      user_4 = User.create(username: '133t')

      review_1 = Review.create(title: 'This Book Was Gneiss', rating: 5, description: 'Super rad', user_id: user_1.id, book_id: book_1)
      review_2 = Review.create(title: 'This Book Was Terrible', rating: 1, description: 'Mega terrible', user_id: user_2.id, book_id: book_1)
      review_3 = Review.create(title: 'This Book Was Solid', rating: 5, description: 'Solid', user_id: user_1.id, book_id: book_2)
      review_4 = Review.create(title: 'This Book Was Horrible', rating: 1, description: 'Bad Bad Bad', user_id: user_2.id, book_id: book_2)
      review_5 = Review.create(title: 'This Book Was Terrific', rating: 4, description: 'Super x99', user_id: user_3.id, book_id: book_2)
      review_6 = Review.create(title: 'This Book Was Abyssmal', rating: 2, description: 'Worse than bad', user_id: user_4.id, book_id: book_2)

      visit '/books'

      save_and_open_page

      within "#book-#{book_1.id}" do
        expect(page).to have_content('Average rating: 3')
        expect(page).to have_content('Total reviews: 2')
      end

      within "#book-#{book_2.id}" do
        expect(page).to have_content('Average rating: 3')
        expect(page).to have_content('Total reviews: 4')
      end
    end
  end
end
