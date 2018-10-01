Rails.application.routes.draw do
	
  get 'cupboards/new'
  get 'cupboards/edit'
  get 'stationary/new'
  get 'stationary/edit'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/new_stationary', to: 'items#new'
  get    '/new_cupboard', to: 'cupboards#new'
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :users
  resources :items
  resources :cupboards

end
