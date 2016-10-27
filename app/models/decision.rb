class Decision
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String, default: ''
  field :visibility, type: Symbol
  field :short_url, default: -> { generate_short_url }

  validates_presence_of :name
  validates_uniqueness_of :short_url
  validates_inclusion_of :visibility, in: [:public, :private]

  has_many :criteria
  has_many :alternatives

  has_many :user_decisions

  CHARSET = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a

  def generate_short_url
    s = nil
    while s.nil? or Decision.where(short_url: s).exists?
      s = 4.times.map { CHARSET.sample }.join
    end
    s
  end
end
