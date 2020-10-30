class PricesController < ApplicationController

  before_action :exist_price?, only: [:update, :destroy]
  before_action :set_price, only: [:output, :destroy]
  before_action :authenticate, except: [:new_browser, :index]
  after_action :create, only: :input

  AUTHENTICATION_TOKEN = ENV['AUTHENTICATION_TOKEN']

  def authenticate
    render json: "不正なリクエストです" unless params[:token] == AUTHENTICATION_TOKEN
  end

  def set_price
    @price = Price.find_by(name: params[:name])
  end

  def exist_price?
    name = params[:name]
    render text: "#{name}が見つかりません" unless Price.find_by(name: name)
  end

  def index
    render json: "hello", adapter: :json
  end

  def create
    PriceCreateWorker.perform_async(params[:name])
  end

  def input
    price = Price.new(name: params[:name])
    p "#{price.name} has created!" if price.save
  end

  def output
    render json: @price, adapter: :json
  end

  def update
    @price = Price.find_by(name: params[:old_name])
    text = "--------------------#{@price.name} is updated---------------------"
    render json: text, adapter: :json if @price.update(name: params[:name])
  end

  def destroy
    text = "--------------------#{@price.name} is deleted---------------------"
    render json: text, adapter: :json if @price.destroy
  end

  def self.prices_reload
    prices = Price.pluck(:name)
    PriceReloadWorker.perform_asyncs(prices)
  end

end
