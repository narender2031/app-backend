Rails.application.routes.draw do
 
 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API => '/'
  get '/docs' => redirect('/swagger-ui/dist/index.html?url=/swagger_docs')
  get '/dash', to: "dash#index"
  root "dash#index"
end
