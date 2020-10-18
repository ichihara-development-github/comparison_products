module Scraping

  require 'nokogiri'
  require 'open-uri'
  require "csv"
  require "byebug"
  require "selenium-webdriver"

  options = Selenium::WebDriver::Chrome::Options.new
  options.binary = ENV["CHROME_SHIM"]
  options.add_argument('disable-gpu')
  options.add_argument('headless')
  $driver = Selenium::WebDriver.for :chrome, options: options


  RAKUTEN_URL = "https://www.rakuten.co.jp/"
  AMAZON_URL = "https://www.amazon.co.jp/"

  def collect_rakuten(search_elm)
    p "hello"
  end

  def collect_amazon(search_elm)
    $driver.get(AMAZON_URL)
    search_box = $driver.find_element(:id, 'twotabsearchtextbox')
    btn = $driver.find_element(:xpath, '//*[@id="nav-search"]/form/div[3]/div')
    search_box.send_keys(search_elm)
    btn.click
    sleep 3
    select = Selenium::WebDriver::Support::Select.new($driver.find_element(:id, "s-result-sort-select"))
    select.select_by(:value, "review-rank")
    sleep 3
    amazon = scrap_price("a-price-whole",d)
    $driver.close
    amazon
  end

  def scrap_price(elm)
    prices = $driver.find_elements(:class, elm)
    price_list = prices.map{|price| price.text.delete!("￥,").to_i}
  end

end
