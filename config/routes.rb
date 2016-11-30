Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

  resources :senders do
    get 'daily_operations', to: "senders#daily_operations"
    get 'daily_transfers', to: "senders#daily_transfers"

    resources :receivers, only: [:index, :new, :create, :destroy, :show]
    resources :transfers, only: [:index, :new, :create] 

    resources :operations, only: [:index, :create]
    get 'operations/new_deposit', to: "operations#new_deposit", as: :new_deposit
    get 'operations/new_withdrawal', to: "operations#new_withdrawal", as: :new_withdrawal
  end

  resources :employees

  get '/transfers/search', to: "transfers#search", as: :search_transfers
  post '/transfers/search', to: "transfers#pending", as: :pending_transfers
  get '/transfers/:id/complete', to: "transfers#get_code", as: :get_transfer_code
  post '/transfers/:id/complete', to: "transfers#complete_transfer", as: :complete_transfer

  get '/login', to:"logins#new"
  post '/login', to:"logins#create"
  get '/logout', to:"logins#destroy"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
