Rails.application.routes.draw do
  resources :messages, only: [:create] do
    collection do
      get "/:recipient_id/recent" => "messages#recent", as: :recent
    end
  end

  resources :users, only: [:index, :show] do
    get :messages
  end
end
