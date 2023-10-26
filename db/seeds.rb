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
cities = ["Sète", "Marseille", "Balaruc", "Frontignan", "Mèze", "Poussan"]
cities.each do |city| 
  City.create(name: city) 
end

# Créez des promeneurs (dogsitters) et des chiens (dogs) pour chaque ville
cities.each do |city_name|
  city = City.find_by(name: city_name)
  
  10.times do
    dogsitter = Dogsitter.create(name: Faker::Name.name, city: city)
    dog = Dog.create(name: Faker::Creature::Dog.name, city: city)
  end
end

# Créez des promenades (strolls) avec une date aléatoire
30.times do |i|
  date = Faker::Time.between(from: DateTime.now - (100 - i), to: DateTime.now - 100, format: :default)
  
  dogsitter = Dogsitter.all.sample
  dog = Dog.all.sample
  
  Stroll.create(date: date, dog: dog, dogsitter: dogsitter, city: dog.city)
end