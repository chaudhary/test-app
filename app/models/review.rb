class Review
  include Mongoid::Document

  belongs_to :movie
  belongs_to :user

  field :stars, type: Integer
  field :review, type: String

  after_save do 
    self.movie.update_avg_rating
  end
end