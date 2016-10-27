class UserDecision
  include Mongoid::Document
  include Mongoid::Timestamps

  field :arguments, type: String
  field :role, type: Symbol

  validates_inclusion_of :role, in: [:owner, :member]

  belongs_to :user
  belongs_to :decision

  has_many :scores

  def owner?
    self.role == :owner
  end
end
