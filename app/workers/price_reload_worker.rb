class PriceReloadWorker
  include Scraping

  def perform(prices)
    driver = new_browser
    driver.get(AMAZON_URL)
    search_box = driver.find_element(:id, 'twotabsearchtextbox')
    btn = driver.find_element(:xpath, '//*[@id="nav-search"]/form/div[3]/div')
    prices.each do |price|
      search_box.send_keys(product)
      btn.click
      sleep 3
      select = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "s-result-sort-select"))
      select.select_by(:value, "review-rank")
      sleep 3
      amazon = scrap_price("a-price-whole", driver)
      average = amazon.sum / amazon.length
      max = amazon.max
      min = amazon.min
      price.update(average:average, max: max, min: min)
    end
    driver.close
    amazon
  end
end
