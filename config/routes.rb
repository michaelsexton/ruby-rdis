Rails.application.routes.draw do






  resources :duplicates do
    member do
      put :qa
      patch :qa
      
    end
    collection do 
      get :backup
    end
  end
  
  resources :boreholes 
  
  resources :borehole_wells
  resources :borehole_mineral_attributes
  resources :borehole_entity_attributes
  
  resources :borehole_wdata_twos

  resources :borehole_wdata_ones

  resources :borehole_porperm_picks

  resources :borehole_porperm_twos

  resources :borehole_porperm_ones

  resources :borehole_sidetracks

  resources :borehole_resfacs_remarks

  resources :borehole_stratigraphies

  resources :borehole_dir_survey_stations

  resources :borehole_dir_surveys

  resources :borehole_resultws

  resources :borehole_remarkws

  resources :borehole_well_confids

  resources :borehole_samples
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
