Rails.application.routes.draw do
### Need to edit routes so that you can't create a maintenance category unless it's associated with an item and you can't create a log unless it's associated with a category
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :maintenance_items do
    resources :maintenance_logs, only: [:index, :show, :new, :edit, :create]
    resources :maintenance_categories, only: [:index, :show, :new, :edit, :create]
  end 
  resources :maintenance_logs
  resources :maintenance_categories 

  get 'past_due', to: "maintenance_logs#past_due"
  get 'upcoming', to: "maintenance_logs#upcoming"

  get 'maintenance_logs/:id/log_data', to: 'maintenance_logs#log_data'
  
  root "maintenance_items#index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
