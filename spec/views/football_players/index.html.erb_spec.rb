require 'rails_helper'

RSpec.describe "football_players/index", type: :view do
  before(:each) do
    assign(:football_players, [
      FootballPlayer.create!(),
      FootballPlayer.create!()
    ])
  end

  it "renders a list of football_players" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
