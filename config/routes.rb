Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "price/:name", to: "prices#output"
  post "price/new/:name", to: "prices#input"
end
