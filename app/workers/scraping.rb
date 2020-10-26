module Scraping

  require 'nokogiri'
  require 'open-uri'
  require "csv"
  require "byebug"
  require "selenium-webdriver"

  RAKUTEN_URL = "https://www.rakuten.co.jp/"
  AMAZON_URL = "https://www.amazon.co.jp/"

  def new_browser
    options = Selenium::WebDriver::Chrome::Options.new
    # options.binary = ENV['GOOGLE_CHROME_SHIM']
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-gpu')
    options.add_argument('--headless')
    options.add_argument('--remote-debugging-port=9222')
    options.add_argument('--window-size=144,100')
    driver = Selenium::WebDriver.for :chrome, options: options
  end



  def collect_amazon(search_elm, driver)
    driver.get(AMAZON_URL)
    search_box = driver.find_element(:id, 'twotabsearchtextbox')
    btn = driver.find_element(:xpath, '//*[@id="nav-search"]/form/div[3]/div')
    search_box.send_keys(search_elm)
    btn.click
    sleep 3
    select = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "s-result-sort-select"))
    select.select_by(:value, "review-rank")
    sleep 3
    amazon = scrap_price("a-price-whole", driver)
    driver.close
    amazon
  end

  def scrap_price(elm, driver)
    prices = driver.find_elements(:class, elm)
    price_list = prices.map{|price| price.text.delete!("￥,").to_i}
  end

end
