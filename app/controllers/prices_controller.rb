  require "./lib/scraping"

  class PricesController < ApplicationController
  include Scraping

  before_action :set_price, before: [:output, :create]

  def set_price
    @price = Price.find_by(name: params[:name])
  end


  def create
    @prices = collect_amazon(@price.name)
    average = @prices.sum / @prices.length
    max = @prices.max
    min = @prices.min
    @price.update(average:average, max: max, min: min)
    render json: @price, adapter: :json
  end


  def input
    price = Price.new(name: params[:name])
    render json: "#{price} has created", adapter: :json if price.create
  end

  def output
    render json: @price, adapter: :json
  end


end
