require "rails_helper"

RSpec.describe FootballPlayersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/football_players").to route_to("football_players#index")
    end

    it "routes to #new" do
      expect(get: "/football_players/new").to route_to("football_players#new")
    end

    it "routes to #show" do
      expect(get: "/football_players/1").to route_to("football_players#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/football_players/1/edit").to route_to("football_players#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/football_players").to route_to("football_players#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/football_players/1").to route_to("football_players#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/football_players/1").to route_to("football_players#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/football_players/1").to route_to("football_players#destroy", id: "1")
    end
  end
end
