require 'faker'
require 'net/http'
require 'json'

puts "Seeding database..."

# Fetch Data from SWAPI API
def fetch_swapi_characters
  url = URI("https://swapi.dev/api/people/")
  response = Net::HTTP.get(url)
  JSON.parse(response)["results"]
end

def fetch_swapi_films
  url = URI("https://swapi.dev/api/films/")
  response = Net::HTTP.get(url)
  JSON.parse(response)["results"]
end

# Reset Database
Appearance.destroy_all
Character.destroy_all
Film.destroy_all

# Create Films from SWAPI API
swapi_films = fetch_swapi_films
swapi_films.each do |film|
  Film.create!(
    title: film["title"],
    episode: film["episode_id"],
    release_date: film["release_date"]
  )
end

puts "✅ Created #{Film.count} films"

# Create 150 Faker Characters
150.times do
  Character.create!(
    name: Faker::Movies::StarWars.character,
    species: Faker::Movies::StarWars.specie,
    birth_year: "#{rand(20..100)}BBY",
    gender: ["male", "female", "other"].sample
  )
end

# Create 50 Characters from SWAPI API
swapi_characters = fetch_swapi_characters
swapi_characters.each do |char|
  Character.create!(
    name: char["name"],
    species: char["species"].empty? ? "Unknown" : char["species"].join(", "),
    birth_year: char["birth_year"],
    gender: char["gender"]
  )
end

puts "✅ Created #{Character.count} characters"

# Create 200 Appearances (Random Assignments of Characters to Films)
characters = Character.all
films = Film.all

200.times do
  Appearance.create!(
    character: characters.sample,
    film: films.sample
  )
end

puts "✅ Created #{Appearance.count} film-character appearances"

puts "✅ Seeding complete! Total Rows:"
puts "- Characters: #{Character.count}"
puts "- Films: #{Film.count}"
puts "- Appearances: #{Appearance.count}"
