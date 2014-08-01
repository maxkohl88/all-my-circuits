Rails.application.routes.draw do
  devise_for :users,
  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: 'home#show'

  devise_scope :user do
    # get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    # get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  match '/sendlike', to: 'chats#find_or_create', via: 'post'
  match '/matches', to: 'chats#matches', via: 'get'
  resources :chats, only: [:index, :create, :destroy, :update] do
    resources :messages, only: [:index, :create]
  end
  resources :users
  resources :after_signup

end
