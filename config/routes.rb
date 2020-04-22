# frozen_string_literal: true

Rails.application.routes.draw do
  resources :messages, only: [:create] do
    collection do
      get "/:recipient_id/recent" => "messages#recent", as: :recent
      get "/:recipient_id/recent/:sender_id" => "messages#recent_from_sender", as: :recent_from_sender
    end
  end

  resources :users, only: %i[index show] do
    get :messages
  end
end
