Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  if SETTINGS['registration_is_enabled']
    devise_for :users
  else
    devise_for :users, skip: :registrations

    as :user do
      delete 'users/cancel' => 'devise/registrations#cancel', :as => 'cancel_user_registration'
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      patch 'users' => 'devise/registrations#update', :as => 'user_registration'
      put 'users' => 'devise/registrations#update', :as => ''
      delete 'users' => 'devise/registrations#destroy', :as => ''
    end
  end

  root 'home#show'
  resources :posts
  get 'posts/category/:category', to: 'posts#index', :as => 'category'
  get 'posts/tags/:tag', to: 'posts#index', :as => 'tag'
  get 'posts/category/:category/tags/:tag', to: 'posts#index', :as => 'category_with_tag'
  get 'about' => 'static_pages#about', :as => 'about'
  get 'imprint' => 'static_pages#imprint', :as => 'imprint'
  get 'privacy_policy' => 'static_pages#privacy_policy', :as => 'privacy_policy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
