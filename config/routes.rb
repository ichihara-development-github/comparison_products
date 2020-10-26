require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/price", to: "prices#output"
  post "/price/new/", to: "prices#input"
  # post "/price/create", to: "prices#create"
  patch "/price", to: "prices#update"
  delete "/price", to: "prices#destroy"

  root to: "prices#index"


end
