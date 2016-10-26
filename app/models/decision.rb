class Decision
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :visibility, type: Symbol

  validates_inclusion_of :visibility, in: [:public, :private]

  has_many :criteria
  has_many :alternatives

  has_many :user_decisions
end
