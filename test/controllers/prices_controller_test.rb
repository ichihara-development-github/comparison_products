require 'test_helper'

class PricesControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get prices_input_url
    assert_response :success
  end

  test "should get output" do
    get prices_output_url
    assert_response :success
  end

end
