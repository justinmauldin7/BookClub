require 'rails_helper'

describe 'user_index' do
  describe 'as a user' do
    it 'can see all books' do
      book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
      book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)
      book_3 = Book.create(title:'How To Test Tests', pages: 64, year: 2018)

      visit '/books'

      expect(page).to have_content(book_1.title)
      expect(page).to have_content("Pages: #{book_1.pages}")
      expect(page).to have_content("Year: #{book_1.year}")
      expect(page).to have_content(book_2.title)
      expect(page).to have_content("Pages: #{book_2.pages}")
      expect(page).to have_content("Year: #{book_2.year}")
      expect(page).to have_content(book_3.title)
      expect(page).to have_content("Pages: #{book_3.pages}")
      expect(page).to have_content("Year: #{book_3.year}")
    end

    it 'can see authors' do
      book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)
      book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)

      author_1 = Author.create(name: 'Rock Man')
      author_2 = Author.create(name: 'Rock Woman')

      rel_1 = BookAuthor.create(book_id: book_1.id, author_id: author_1.id)
      rel_2 = BookAuthor.create(book_id: book_2.id, author_id: author_2.id)

      visit '/books'

      expect(page).to have_content(author_1.name)
      expect(page).to have_content(author_2.name)
    end
  end
end
