Rails.application.routes.draw do
 root to: 'home#index'
  devise_for :users


  get 'users/withdrawal' => 'users#withdrawal'
  resources :users, only: %i[index show edit update destroy]
  resources :home, only: %i[index]
  get 'home/about' => 'home#about'
  resources :musics, only: %i[index show create edit update destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
