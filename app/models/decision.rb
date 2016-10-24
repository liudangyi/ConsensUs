class Decision
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :visibility, type: Symbol
  belongs_to :owner, class_name: 'User'

  has_many :criteria
  has_many :candidates

  has_many :user_decisions
end
