Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "price/:name", to: "prices#output"
  post "price/new/:name", to: "prices#input"
  post "price/create/:name", to: "price#inout"
end
