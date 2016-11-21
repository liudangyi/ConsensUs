class Score
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Float
  field :argument, type: String, default: ''

  validates_presence_of :value

  belongs_to :criterium
  belongs_to :alternative

  belongs_to :membership

  def as_json(option = {})
    value
  end
end
