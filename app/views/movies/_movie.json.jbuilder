json.extract! movie, :id, :name, :description, :year, :director_id, :created_at, :updated_at
json.url movie_url(movie, format: :json)

json.locations movie.locations do |location|
  json.id location.id
  json.name location.name
  json.country location.country
end

json.actors movie.actors do |actor|
  json.id actor.id
  json.name actor.name
end