desc "refresh all product prices"
task :reload_prices => :environment do
  PricesController.prices_reload
  p Price.all
end
