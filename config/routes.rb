Rails.application.routes.draw do
  root to: 'events#index'
  resources :events
  resource :alexa, controller: 'alexa'
end
