ActionController::Routing::Routes.draw do |map|
  map.resources :submissions
  map.resources :resumes
  map.resources :front
  map.resources :resumes
  map.resources :users, :has_one => :profile
  map.resource :session
  map.resources :positions do |pos|
    pos.resources :questions, :member => { :up => :put, :down => :put }
  end
  map.resources :answers
  map.resources :questions
  map.resources :categories
  map.resources :applications
  map.resources :profiles
  map.search '/search/:query', :controller => 'search', :action => 'search'
  map.search '/search', :controller => 'search', :action => 'search'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.change_password '/change_password', :controller => 'users', :action => 'change_password'
  map.resume 'resumes/:id', :controller => 'resumes', :action => 'show'
  map.success '/success', :controller => 'front', :action => 'success'
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"
  map.root :controller => 'front'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
