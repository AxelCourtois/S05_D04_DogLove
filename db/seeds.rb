# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



require 'faker'
Faker::Config.locale = 'fr'

# Supprimez toutes les données existantes
Stroll.destroy_all
Dog.destroy_all
Dogsitter.destroy_all
City.destroy_all

# Créez les villes
cities = %w[Sète Marseille Balaruc Frontignan Mèze Poussan]
cities.each { |city| City.create(name: city) }

# Créez des promeneurs (dogsitters) et des chiens (dogs) pour chaque ville
cities.each do |city_name|
  chosen_city = City.find_by(name: city_name)
  
  10.times do
    dogsitter = Dogsitter.create(name: Faker::Name.name, city: chosen_city)
    dog = Dog.create(name: Faker::Creature::Dog.name, city: chosen_city)
  end
end

# Créez des promenades (strolls) avec une date aléatoire
30.times do |i|
  datetime = Faker::Time.betwee(from: DateTime.now - (100 - i), to: DateTime.now - 100, format: :default)
  
  chosen_dogsitter = Dogsitter.all.sample
  chosen_dog = Dog.all.sample
  
  Stroll.create(date: datetime, dog: chosen_dog, dogsitter: chosen_dogsitter, city: chosen_dog.city)
end