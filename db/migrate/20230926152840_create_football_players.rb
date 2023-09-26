class CreateFootballPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :football_players do |t|

      t.timestamps
    end
  end
end
