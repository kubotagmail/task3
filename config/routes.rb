Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  resources :books, only: [:edit, :index, :show, :create, :destroy, :update]
  resources :users, only: [:edit, :index, :show, :update]

  get '/home/about' => 'homes#about', as: "about"
end
