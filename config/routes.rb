Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :rooms, :only => [:create]
  end
  resources :musics, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resource :music_comments, only: [:create]
  end
  resources :music_comments, only: [:destroy]

  resources :rooms, :only => [:show] do
    resources :chats, :only => [:create]
  end

  root 'home#top'
  get 'home/about'
  get 'searches/search', as: 'search'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
