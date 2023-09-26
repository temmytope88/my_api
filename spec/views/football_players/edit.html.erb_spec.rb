require 'rails_helper'

RSpec.describe "football_players/edit", type: :view do
  let(:football_player) {
    FootballPlayer.create!()
  }

  before(:each) do
    assign(:football_player, football_player)
  end

  it "renders the edit football_player form" do
    render

    assert_select "form[action=?][method=?]", football_player_path(football_player), "post" do
    end
  end
end
