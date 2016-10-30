class Membership
  include Mongoid::Document
  include Mongoid::Timestamps

  field :arguments, type: String, default: ''
  field :role, type: Symbol
  field :invited_email, type: String

  validates_inclusion_of :role, in: [:owner, :member]
  validates_presence_of :invited_email
  validates_uniqueness_of :invited_email, scope: :decision, message: "is already in this decision"

  belongs_to :user, optional: true
  belongs_to :decision

  has_many :scores

  validate :at_least_one_owner

  before_validation do
    self.user = User.where(email: invited_email).first if invited_email and user.nil?
    self.invited_email = user.email if invited_email.nil? and user
  end

  def at_least_one_owner
    if self.role_change == [:owner, :member] and Membership.where(decision_id: self.decision_id, role: :owner).count == 1
      errors.add :role, "cannot be set to member: there must be at least one owner"
    end
  end

  def owner?
    self.role == :owner
  end
end
