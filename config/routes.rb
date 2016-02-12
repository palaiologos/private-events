Rails.application.routes.draw do
  root   'static_pages#home'

  get    'signup' => 'users#new'
  get 	 'login'  => 'sessions#new'
  post 	 'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 	 'events' => 'events#index'

  resources :users, only: [ :new, :create, :show ]
  resources :events, only: [ :new, :create, :show ]
  resources :invites, only: [ :create , :destroy ]
end
