class Location
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :country, type: String
end