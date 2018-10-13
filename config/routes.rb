Rails.application.routes.draw do
  devise_for :users
  resources :wikis
  resources :charges

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
