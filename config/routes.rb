Rails.application.routes.draw do
    get "pages/show"
  root "products#index"
  get "/pages/:title", to: "pages#show", as: "page"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :customers, controllers: {
  registrations: 'customers/registrations'
}

  get "admin", to: "admin#dashboard"

  resources :products
  resources :categories
  resources :pages, only: [:edit, :update]
  resources :orders
  resources :orders, only: [:new, :create, :show, :index]
  resources :payments, only: [:create]
  post 'cart/add/:id', to: 'cart#add', as: 'add_to_cart'
  post "/payments/confirm", to: "payments#confirm"
get 'cart', to: 'cart#show'
delete 'cart/remove/:id', to: 'cart#remove', as: 'remove_from_cart'
patch 'cart/update/:id', to: 'cart#update', as: 'update_cart'


end