Rails.application.routes.draw do
  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :collaborators, only: [:create, :destroy]

  get 'downgrade' => 'downgrade#downgrade'
  get 'charges/new' => 'charges#new'


  get 'about' => 'welcome#about'

  root 'welcome#index'
end
