require 'rails_helper'

describe 'user_index' do
  it 'user can see all books' do
    book_1 = Book.create(title:'How to test ruby', pages: 2, year: 1934)
    book_2 = Book.create(title:'How to test diamonds', pages: 3853, year: 1895)
    book_3 = Book.create(title:'How to test tests', pages: 64, year: 2018)

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
end
