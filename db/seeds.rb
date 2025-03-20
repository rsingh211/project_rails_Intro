require 'faker'
require 'net/http'
require 'json'

# Fetch data from SWAPI API
def fetch_swapi_characters
  url = URI("https://swapi.dev/api/people/")
  response = Net::HTTP.get(url)
  JSON.parse(response)["results"]
end

# Create films
films = [
  { title: "A New Hope", episode: 4, release_date: "1977-05-25" },
  { title: "The Empire Strikes Back", episode: 5, release_date: "1980-05-21" }
].map { |film| Film.create!(film) }

# Create characters from Faker
10.times do
  Character.create!(
    name: Faker::Movies::StarWars.character,
    species: Faker::Movies::StarWars.specie,
    birth_year: "#{rand(20..100)}BBY",
    gender: ["male", "female", "other"].sample
  )
end

# Create characters from SWAPI
fetch_swapi_characters.each do |char|
  Character.create!(
    name: char["name"],
    species: char["species"].empty? ? "Unknown" : char["species"].join(", "),
    birth_year: char["birth_year"],
    gender: char["gender"]
  )
end

puts "Seeded database successfully!"
