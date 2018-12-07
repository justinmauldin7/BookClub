require 'rails_helper'

describe 'as a user' do
  it 'can visit the home page' do
    visit root_path
    expect(page).to have_content('Welcome')
  end
end
