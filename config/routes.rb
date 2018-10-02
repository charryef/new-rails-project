Rails.application.routes.draw do
  get 'wikis/index'
  get 'wikis/show'
  get 'wikis/new'
  get 'wikis/edit'
  devise_for :users
  resources :wikis

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
