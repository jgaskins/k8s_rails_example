require 'sidekiq/web'

Rails.application.routes.draw do
  resources :posts
  mount Sidekiq::Web, at: '/sidekiq'
end
