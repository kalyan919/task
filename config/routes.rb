Rails.application.routes.draw do
  post '/users', to: 'users#create'
  post '/login', to: 'users#login'

  get '/blogs', to: 'blogs#index'
  post '/blogs', to: 'blogs#create'
end
