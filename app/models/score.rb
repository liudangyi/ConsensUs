class Score
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Float

  belongs_to :criterium
  belongs_to :candidate

  belongs_to :user_decision
end
