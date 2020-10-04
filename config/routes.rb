Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/hooks/bridge/create_registration' => 'webhooks#create'
  post '/hooks/bridge/delete_registration' => 'webhooks#destroy'
  post '/hooks/bridge/update_registration' => 'webhooks#update'

  post '/api/users/user_sync' => 'api/users#add_to_db'

  namespace :api do
    resources :registrations

  end

end
