Rails.application.routes.draw do
  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  
  resources :users, except: [:index, :edit, :show]
  get 'users/:username', to: 'users#show', as: 'username'
  get 'profile/edit', to: 'users#edit', as: 'edit/profile'
  get 'profile/close', to: 'users#close', as: 'close_profile'
  resources :chirps
  root 'chirps#index'
end
