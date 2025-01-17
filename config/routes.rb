Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  get '/homes/about' => 'public/homes#about', as: 'about'

  get "/customers/my_page" => "public/customers#show", as: "my_page"
  get "/customers/information/edit" => "puclic/customers#edit", as: "info_edit"
  patch "/customers/information" => "public/customers#update", as: "info_update"
  get "/customers/unsubscribe" => "pulic/customers#unsubscribe", as: "unsubscribe"
  patch "/customers/withdraw" => "public/customers#withdraw", as: "withdraw"

  scope module: :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete "destroy_all"
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "thanks"
      end
    end
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end
  
  get "admin" => "admin/homes#top"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
