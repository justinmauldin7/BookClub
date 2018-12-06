require 'rails_helper'

describe "user creates new book on book new page" do
  it "shows create fields" do
    book_1 = Book.create(title:'How To Test Ruby', pages: 2, year: 1934)

    visit new_book_path

    expect(page).to have_content("Title")
    expect(page).to have_content("Authors")
    expect(page).to have_content("Pages")
    expect(page).to have_content("Year")
  end

  it "creates a new book" do
    book_2 = Book.create(title:'How To Test Diamonds', pages: 3853, year: 1895)

    author_2 = Author.create(name: 'Rock Woman')
    author_3 = Author.create(name: 'Rock Child')

    rel_2 = BookAuthor.create(book_id: book_2.id, author_id: author_2.id)
    rel_3 = BookAuthor.create(book_id: book_2.id, author_id: author_3.id)

    visit new_book_path

    fill_in :book_title, with: book_2.title
    fill_in :book_authors, with: " rock woman , rock child"
    fill_in :book_pages, with: book_2.pages
    fill_in :book_year, with: book_2.year

    click_on "Create Book"

    expect(current_path).to eq("/books/#{Book.last.id}")
    expect(page).to have_content(book_2.title)
    expect(page).to have_content("Rock Woman")
    expect(page).to have_content("Rock Child")
    expect(page).to have_content(book_2.pages)
    expect(page).to have_content(book_2.year)
  end
end
