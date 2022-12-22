Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    collection do
      post :account
    end
  end
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/inbox" if Rails.env.development?
end
