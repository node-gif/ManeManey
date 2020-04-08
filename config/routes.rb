Rails.application.routes.draw do
  get 'boards/index'
  get 'boards/show'
  get 'boards/new'
  get 'boards/edit'
  devise_for :users,
    controllers: { registrations: 'registrations' }
    
  root 'pages#home'
  
  get '/users/:id', to: 'users#show', as: 'user'
end
