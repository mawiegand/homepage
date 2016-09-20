Rails.application.routes.draw do
  SETTINGS['registration_is_enabled'] ? (devise_for :users) : (devise_for :users, skip: [:registrations])
  root 'home#show'
  resources :posts

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
