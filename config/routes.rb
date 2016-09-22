Rails.application.routes.draw do
  if SETTINGS['registration_is_enabled']
    devise_for :users
  else
    devise_for :users, skip: :registrations

    as :user do
      delete 'users/cancel' => 'devise/registrations#cancel', :as => 'cancel_user_registration'
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      patch 'users' => 'devise/registrations#update', :as => 'user_registration'
      delete 'users' => 'devise/registrations#destroy', :as => ''
    end
  end

  root 'home#show'
  resources :posts

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
