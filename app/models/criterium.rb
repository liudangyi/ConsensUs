class Criterium
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String, default: ''

  validates_presence_of :name

  belongs_to :decision

  def as_json(options = {})
    {
      id: id.to_s,
      name: name,
      description: description,
    }
  end
end
