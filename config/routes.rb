Rails.application.routes.draw do
  get 'sessions/new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  
  resources :users, except: [:index, :edit, :show]
  get 'users/:username', to: 'users#show', as: 'username'
  get 'follow/:id', to: 'users#follow', as: 'follow_user'
  get 'unfollow/:id', to: 'users#unfollow', as: 'unfollow_user'

  get 'profile/edit', to: 'users#edit', as: 'edit/profile'
  get '/profile/edit/password', to: 'users#password', as: 'edit_password'
  get 'profile/close', to: 'users#close', as: 'close_profile'
  resources :chirps
  root 'chirps#index'
end
