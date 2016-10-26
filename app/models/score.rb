class Score
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Float
  field :argument, type: String

  belongs_to :criterium
  belongs_to :alternative

  belongs_to :user_decision
end
