require 'rails_helper'

RSpec.describe "football_players/new", type: :view do
  before(:each) do
    assign(:football_player, FootballPlayer.new())
  end

  it "renders new football_player form" do
    render

    assert_select "form[action=?][method=?]", football_players_path, "post" do
    end
  end
end
