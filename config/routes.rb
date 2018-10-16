Rails.application.routes.draw do
  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create]
  get 'charges/downgrade' => 'charges#downgrade'
  get 'charges/new' => 'charges#new'


  get 'about' => 'welcome#about'

  root 'welcome#index'
end
