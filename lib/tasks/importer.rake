namespace :import do
  desc "Import Movies" 
  task movies: :environment do 
    require 'csv'
    rows = CSV.read(Rails.root.join("db/seeds/movies.csv"), headers: true)
    rows.each do |row|
      actor = User.find_or_create_by!(name: row['Actor'])
      director = User.find_or_create_by!(name: row['Director'])
      movie = Movie.find_or_create_by!(name: row['Movie'])
      location = Location.find_or_create_by!(
        name: row['Filming location'],
        country: row['Country']
      )
      movie.description = row['Description']
      movie.year = row['Year']
      movie.director = director
      movie.actor_ids |= [actor.id]
      movie.location_ids |= [location.id]
      movie.save!
    end
  end

  desc "Import Reviews" 
  task reviews: :environment do 
    require 'csv'
    rows = CSV.read(Rails.root.join("db/seeds/reviews.csv"), headers: true)
    rows.each do |row|
      user = User.find_or_create_by!(name: row['User'])
      movie = Movie.find_or_create_by!(name: row['Movie'])
      review = Review.find_or_create_by!(movie: movie, user: user)
      review.update!(
        stars: row['Stars'],
        review: row['Review']
      )
    end
  end
end
