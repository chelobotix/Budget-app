Rails.application.routes.draw do
  root 'home#index'
  get 'home/index', to: 'home#index'
  resources :payments, except: [:index, :show]
  resources :categories
  devise_for :users

  get 'payment_create_new/:category_id', to: 'payments#new_payment', as: 'payment_create_new'
  post 'payment_create_new/:category_id', to: 'payments#create_payment', as: 'payment_create_new_post'
end
