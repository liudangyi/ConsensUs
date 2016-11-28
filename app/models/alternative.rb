class Alternative
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String, default: ''
  field :color, type: String, default: -> { generate_color }

  validates_presence_of :name, :color

  belongs_to :decision
  has_many :scores, dependent: :destroy

  def generate_color
    '#' + Color::HSL.new(rand(360), 80, 55).to_rgb.hex
  end

  def as_json(options = {})
    {
      id: id.to_s,
      name: name,
      description: description,
      color: color,
    }
  end
end
