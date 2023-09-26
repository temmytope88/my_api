class CreateFootballPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :football_players do |t|
      t.string :short_name, :null => false
      t.string :long_name, :null => false
      t.string :player_positions, :null => true
      t.integer :overall, :null => true
      t.integer :potential, :null => true
      t.integer :age, :null => true
      t.date :dob, :null => true
      t.integer :height, :null => true
      t.string :club_name, :null => true
      t.string :league_name, :null => true
      t.string :club_position, :null => true
      t.integer :club_jersey, :null => true
      t.date :club_joined, null: true
      t.string :nationality, :null => true
      t.string :preferred_foot, null: true
      t.integer :pace, :null => true
      t.integer :shooting, :null => true
      t.integer :passing, :null => true
      t.integer :dribbling, :null => true
      t.integer :defending, :null => true
      t.integer :physical, :null => true
      t.integer :crossing, :null => true
      t.integer :finishing, :null => true
      t.integer :heading, :null => true
      t.integer :short_pass, :null => true
      t.integer :volleys, :null => true
      t.integer :skills, :null => true
      t.integer :control, :null => true

      t.timestamps
    end
  end
end
