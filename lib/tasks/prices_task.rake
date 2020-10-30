namespace :prices_task do
  desk "refresh all product prices"
  task :relaod => :production do
    PricesController.prices_reload
  end
end
