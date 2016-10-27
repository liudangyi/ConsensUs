class Membership
  include Mongoid::Document
  include Mongoid::Timestamps

  field :arguments, type: String, default: ''
  field :role, type: Symbol
  field :invited_email, type: String

  validates_inclusion_of :role, in: [:owner, :member]
  validates_uniqueness_of :invited_email, :user, scope: :decision

  belongs_to :user, optional: true
  belongs_to :decision

  has_many :scores

  def owner?
    self.role == :owner
  end
end
