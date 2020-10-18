  require "./lib/scraping"

  class PricesController < ApplicationController
  include Scraping

  before_action :set_price, before: [:output, :create]

  def set_price
    @price = Price.find_by(name: params[:name])
  end

  def index
    render json: "access successful!", adapter: :json
  end


  def create
    @driver = browser
    
    @prices = collect_amazon(@price.name,@driver)
    average = @prices.sum / @prices.length
    max = @prices.max
    min = @prices.min
    @price.update(average:average, max: max, min: min)
    render json: {name: @price.name,average: @price.average, max: @price.max, min: @price.min}, adapter: :json
  end


  def input
    price = Price.new(name: params[:name])
    render json: "#{price.name} has created", adapter: :json if price.save
  end

  def output
    render json: @price, adapter: :json
  end


end
