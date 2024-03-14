class Movie
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :year, type: Integer

  has_and_belongs_to_many :locations, class_name: Location, inverse_of: nil
  has_and_belongs_to_many :actors, class_name: User, inverse_of: nil
  belongs_to :director, class_name: User, inverse_of: nil

  field :avg_rating, type: Float

  def update_avg_rating
    reviews = Review.where(movie_id: self.id)
    avg_rating = reviews.sum(:stars).to_f / reviews.count
    self.update_attributes!(avg_rating: avg_rating)
  end
end
