Bloccit::Application.routes.draw do

  get "comments/create"

  devise_for :users

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end