class CreateEarthquakes < ActiveRecord::Migration[7.0]
  def change
    create_table :earthquakes do |t|
      t.datetime :DateTime
      t.float :Latitude
      t.float :Longitude
      t.float :Depth
      t.float :Magnitude
      t.string :MagType
      t.integer :NbStations
      t.integer :Gap
      t.integer :Distance
      t.float :RMS
      t.string :Source
      t.integer :EventID

      t.timestamps
    end
  end
end
