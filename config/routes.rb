Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, controller: "users" do
    resources :wishes, controller: "wishes"
  end

  resources :wishes, controller: "wishes"

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: 'logout'
  root 'welcome#index'
end
