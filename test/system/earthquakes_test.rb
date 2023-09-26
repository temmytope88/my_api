require "application_system_test_case"

class EarthquakesTest < ApplicationSystemTestCase
  setup do
    @earthquake = earthquakes(:one)
  end

  test "visiting the index" do
    visit earthquakes_url
    assert_selector "h1", text: "Earthquakes"
  end

  test "should create earthquake" do
    visit earthquakes_url
    click_on "New earthquake"

    click_on "Create Earthquake"

    assert_text "Earthquake was successfully created"
    click_on "Back"
  end

  test "should update Earthquake" do
    visit earthquake_url(@earthquake)
    click_on "Edit this earthquake", match: :first

    click_on "Update Earthquake"

    assert_text "Earthquake was successfully updated"
    click_on "Back"
  end

  test "should destroy Earthquake" do
    visit earthquake_url(@earthquake)
    click_on "Destroy this earthquake", match: :first

    assert_text "Earthquake was successfully destroyed"
  end
end
