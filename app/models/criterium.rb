class Criterium
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String, default: ''

  validates_presence_of :name

  belongs_to :decision
end
