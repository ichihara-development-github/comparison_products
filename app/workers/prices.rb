class PricesWorker
  include Sidekiq::Worker

  def perform
    (1..100).each do |price|
      Price.create(name: price)
    end

    (1..100).each do |price|
      Price.destroy_all
    end
end
