  require "./lib/scraping"

  class PricesController < ApplicationController
  include Scraping

  before_action :set_price, only: [:output, :destroy]
  before_action :authenticate, except: [:new_browser, :index]

  AUTHENTICATION_TOKEN = "password"

  def authenticate
    render text: "不正なリクエストです" unless params[:token] == AUTHENTICATION_TOKEN
  end

  def set_price
    @price = Price.find_by(name: params[:name])
  end

  def new_browser
    p "1"
    options = Selenium::WebDriver::Chrome::Options.new
    p "2"
    options.binary = ENV['GOOGLE_CHROME_SHIM']
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-gpu')
    options.add_argument('--headless')
    options.add_argument('--remote-debugging-port=9222')
    options.add_argument('--window-size=144,100')
    p "3"
    driver = Selenium::WebDriver.for :chrome, options: options
  end

  def index
    render json: "hello", adapter: :json
  end


  def create
    p "0"
    @price = Price.find_by(name: params[:name])
    driver = new_browser
    @prices = collect_amazon(@price.name, driver)
    average = @prices.sum / @prices.length
    max = @prices.max
    min = @prices.min
    @price.update(average:average, max: max, min: min)
    p @prices
  end

  def input
    render json: "hello", adapter: :json
    price = Price.new(name: params[:name])
    create if price.save
  end

  def output
    render json: @price, adapter: :json
  end

  def destroy
    text = "--------------------#{price.name} has deleted---------------------"
    render json: text, adapter: :json if price.destroy
  end


end
