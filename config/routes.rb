Rails.application.routes.draw do
  get 'registrations/index'
  get 'registrations/create'
  get 'registrations/update'
  get 'registrations/destroy'
  get 'users/index'
  get 'users/create'
  get 'users/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/hooks/bridge/create_registration' => 'webhooks#create_registration'
  post '/hooks/bridge/delete_registration' => 'webhooks#delete_registration'
end
