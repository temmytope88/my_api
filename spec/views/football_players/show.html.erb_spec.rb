require 'rails_helper'

RSpec.describe "football_players/show", type: :view do
  before(:each) do
    assign(:football_player, FootballPlayer.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
