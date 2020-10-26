require "scraping"

class PriceCreateWorker
  include Sidekiq::Worker
  include Scraping

  sidekiq_options retry: false

  def perform(name)
    p "now #{name}'s price' is creating…"
    @price = Price.find_by(name: name)
    driver = new_browser
    @prices = collect_amazon(@price.name, driver)
    average = @prices.sum / @prices.length
    max = @prices.max
    min = @prices.min
    @price.update(average:average, max: max, min: min)
    p"#{@price.name}'s price has created! #{@prices}"
  end
end
