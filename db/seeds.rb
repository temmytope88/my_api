# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'
require 'time'

#csv_path = Rails.root.join('earthquakesdata.csv') # assuming the file is in the root directory
#CSV.foreach(csv_path,  headers: true) do |row|
#
#  start_time = Time.parse("1930-11-23 00:00:00")
#  last_time = Time.parse("2021-12-01 00:00:00")
#
#  random_time = Time.at(start_time + rand * (last_time.to_f - start_time.to_f))
#  row["DateTime"] = random_time
#  Earthquake.create!(
#    DateTime: row["DateTime"], Latitude: row["Latitude"], Longitude: row["Longitude"], Depth: row["Depth"], Magnitude: row["Magnitude"], MagType: row["MagType"], NbStations: row["NbStations"], Gap: row["Gap"], Distance: row["Distance"], RMS: row["RMS"], Source: row["Source"], EventID: row["EventID"]
#  )
#end

csv_path = Rails.root.join('new_order.csv') # assuming the file is in the root directory
CSV.foreach(csv_path,  headers: true) do |row|

  
  Order.create!(
    customer: row["customer"], employee_id: row["employee_id"], order_date: row["order_date"], required_date: row["required_date"], shipped_date: row["shipped_date"], shipped_id: row["shipped_id"], freight: row["freight"]
  )
end