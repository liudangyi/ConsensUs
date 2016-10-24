class Candidate
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :color, type: String

  belongs_to :decision
end
