class Alternative
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String, default: ''
  field :color, type: String

  validates_presence_of :name, :color

  belongs_to :decision
end
