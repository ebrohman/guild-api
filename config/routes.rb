Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :messages, only: [:create]

  resources :users, only: [:index, :show] do
    get :messages
  end
end
