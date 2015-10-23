Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
 end

  root 'posts#index'

  resources :users do
    resources :posts
  end

  resources :posts do
    resources :comments
  end

end
