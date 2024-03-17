Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get 'home/about' => "homes#about",as: "home_about"
  resources :books, only: [:new, :create, :edit, :update, :index, :show, :destroy]
  resources :users, only: [:show, :edit, :update, :index]
end
