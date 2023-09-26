require "test_helper"

class EarthquakesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @earthquake = earthquakes(:one)
  end

  test "should get index" do
    get earthquakes_url
    assert_response :success
  end

  test "should get new" do
    get new_earthquake_url
    assert_response :success
  end

  test "should create earthquake" do
    assert_difference("Earthquake.count") do
      post earthquakes_url, params: { earthquake: {  } }
    end

    assert_redirected_to earthquake_url(Earthquake.last)
  end

  test "should show earthquake" do
    get earthquake_url(@earthquake)
    assert_response :success
  end

  test "should get edit" do
    get edit_earthquake_url(@earthquake)
    assert_response :success
  end

  test "should update earthquake" do
    patch earthquake_url(@earthquake), params: { earthquake: {  } }
    assert_redirected_to earthquake_url(@earthquake)
  end

  test "should destroy earthquake" do
    assert_difference("Earthquake.count", -1) do
      delete earthquake_url(@earthquake)
    end

    assert_redirected_to earthquakes_url
  end
end
