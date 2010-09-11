class Token < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  uniquify :value
  has_friendly_id :value
end
