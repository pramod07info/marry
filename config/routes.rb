Rails.application.routes.draw do
  #resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 get '/users/code/:unique_code/:device_id', :to => 'users#get_by_unique_code_and_device_code'
 post '/users/device/', :to => 'users#update_by_unique_code'
 get '/users/code/:unique_code', :to => 'users#get_by_unique_code'
 get '/users/device/:device_code', :to => 'users#get_by_device_code'

 resources :users

end
