class FootballPlayerSerializer < ActiveModel::Serializer
  attributes :short_name, :long_name, :player_positions, :overall, :potential, :age, :dob, :height, :club_name, :league_name, :club_position, :club_jersey, :club_joined, :nationality,
  :preferred_foot, :pace, :shooting, :passing, :dribbling, :defending, :physical, :crossing, :finishing, :heading, :short_pass, :volleys, :skills, :control
end
