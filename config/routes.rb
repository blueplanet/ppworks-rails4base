Rails.application.routes.draw do
  devise_for :users
  namespace :my do
    resource :account, only: [:update] do
      resource :setup, controller: 'account_setups', only: [:show]
      resource :byebye, controller: 'account_byebyes', only: [:show]
    end
  end
  root to: 'pages#index', via: [:get, :post]
end
