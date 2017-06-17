Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root "products#index"
  
  namespace :admin do 
    resources :products
    resources :users do 
      member do 
        post :to_admin
        post :to_normal
      end
    end
  end

  resources :products do
    member do 
      post :add_to_cart
    end
  end

  resources :carts do
    collection do 
      post :checkout
      delete :clean
    end
  end

  resources :orders do
    member do 
      get :pay_with_credit_card
    end
  end

  namespace :account do 
    resources :orders
  end

  resources :items, controller: "cart_items"

end
