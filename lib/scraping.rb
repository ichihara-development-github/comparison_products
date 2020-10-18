module Scraping

  require 'nokogiri'
  require 'open-uri'
  require "csv"
  require "byebug"
  require "selenium-webDRIVER"

  RAKUTEN_URL = "https://www.rakuten.co.jp/"
  AMAZON_URL = "https://www.amazon.co.jp/"

  options = Selenium::WebDriver::Chrome::Options.new
  options.binary = ENV["CHROME_SHIM"]
  options.add_argument('--disable-gpu')
  options.add_argument('--headless')
  DRIVER = Selenium::WebDriver.for :chrome, options: options

  def collect_rakuten(search_elm)
    p "hello"
  end

  def collect_amazon(search_elm)
    DRIVER.get(AMAZON_URL)
    search_box = DRIVER.find_element(:id, 'twotabsearchtextbox')
    btn = DRIVER.find_element(:xpath, '//*[@id="nav-search"]/form/div[3]/div')
    search_box.send_keys(search_elm)
    btn.click
    sleep 3
    select = Selenium::WebDriver::Support::Select.new(DRIVER.find_element(:id, "s-result-sort-select"))
    select.select_by(:value, "review-rank")
    sleep 3
    amazon = scrap_price("a-price-whole")
    DRIVER.close
    amazon
  end

  def scrap_price(elm)
    prices = DRIVER.find_elements(:class, elm)
    price_list = prices.map{|price| price.text.delete!("￥,").to_i}
  end

end
