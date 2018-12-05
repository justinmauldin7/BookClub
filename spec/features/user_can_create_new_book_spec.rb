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
end
