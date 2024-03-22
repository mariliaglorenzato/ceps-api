# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "csv"

csv_text = File.read(Rails.root.join("db", "seeds", "zipcodes", "zipcodes.csv"))
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  zipcode = Zipcode.new
  zipcode.street = row["street"]
  zipcode.neighbourhood = row["neighbourhood"]
  zipcode.city = row["city"]
  zipcode.state = row["state"]
  zipcode.country = row["country"]
  zipcode.longitude = row["longitude"]
  zipcode.latitude = row["latitude"]
  zipcode.code = row["zipcode"]
  zipcode.save
end
