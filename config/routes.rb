Rails.application.routes.draw do
  devise_for :users
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end
  resources :charges, only: [:new, :create]

  get 'downgrade' => 'downgrade#downgrade'
  get 'charges/new' => 'charges#new'


  get 'about' => 'welcome#about'

  root 'welcome#index'
end
