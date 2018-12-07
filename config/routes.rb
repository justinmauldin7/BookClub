Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#home'

  resources :books, except: [:update] do
    resources :reviews, only: [:new, :create]
  end

  resources :authors, only: [:show]
end
