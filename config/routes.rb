require 'sidekiq/web'

Rails.application.routes.draw do
  mount proc { [200, {}, ['']] }, at: '/health'

  resources :posts
  mount Sidekiq::Web, at: '/sidekiq'
end
