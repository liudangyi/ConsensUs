class UserDecision
  include Mongoid::Document
  include Mongoid::Timestamps

  field :arguments, type: String

  belongs_to :user
  belongs_to :decision

  has_many :scores
end
