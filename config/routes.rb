Icrb::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :problems, only: [:create, :destroy, :all, :add, :statistics, :update,]
  resources :filials,  only: [:create, :destroy]
  resources :invites

  root               to: 'static_pages#home'
  match '/help',     to: 'static_pages#help'

  # K vrachu
  match '/k_vrachu', to: 'static_pages#k_vrachu'
  match '/documents',to: 'static_pages#documents'

  match '/promed',   to: 'static_pages#promed'

  # About us
  match '/history',  to: 'static_pages#history'
  match '/contacts', to: 'static_pages#contacts'
  match '/licenses', to: 'static_pages#licenses'

  # Problems
  match '/problems/add',        to: 'problems#add'
  match '/problems/all',        to: 'problems#all'
  match '/problems/stat',       to: 'problems#statistics'
  match '/regcode',             to: 'invites#regcode'

  # Sign up / Sign in / Sign out
  match '/signup',   to: 'users#new'
  match '/signin',   to: 'sessions#new'
  match '/signout',  to: 'sessions#destroy', via: :delete


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
