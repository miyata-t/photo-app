Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :photos, only: %i[index new create]
  get 'oauth/callback' => 'oauth#callback'
  resources :tweets, only: %i[create]
end
