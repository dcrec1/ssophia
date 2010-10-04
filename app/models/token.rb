class Token < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  uniquify :value
  has_friendly_id :value

  def to_json(params = {})
    super :include => :user
  end

  def self.find(params)
    super.destroy
  end
end
