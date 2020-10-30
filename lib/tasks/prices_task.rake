namespace :prices_task do
  desc "refresh all product prices"
  task :relaod_prices => :production do
    PricesController.prices_reload
  end
end
