require 'rails_helper'

describe 'as a user' do
  describe 'to add a new review' do
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

    it 'can navigate from show page and add review from current user' do
      visit book_path(@book_1.id)

      title = 'Blew My Mind'
      rating = 4
      description = 'Great book overall.'
      user = 'Teddy'

      expect(page).to have_no_content(title)
      expect(page).to have_no_content(description)
      expect(page).to have_no_content(user)

      click_on 'Add Review'
      expect(current_path).to eq(new_book_review_path(@book_1.id))

      fill_in :review_title, with: title
      fill_in :review_rating, with: rating
      fill_in :review_description, with: description
      fill_in :review_user, with: user

      click_button 'Create Review'

      expect(current_path).to eq(book_path(@book_1.id))

      review = Review.last

      within "#review-#{review.id}" do
        expect(page).to have_content(title)
        expect(page).to have_content(rating)
        expect(page).to have_content(description)
        expect(page).to have_content(user)
      end
    end

      it 'only allows a rating of 1-5' do

        title = 'Blew My Mind'
        rating = 10
        description = 'Great book overall.'
        user = 'Teddy'

        visit new_book_review_path(@book_2.id)

        fill_in :review_title, with: title
        fill_in :review_rating, with: rating
        fill_in :review_description, with: description
        fill_in :review_user, with: user

        click_button 'Create Review'

        expect(current_path).to eq(book_path(@book_2.id))
      end
    end
  end
