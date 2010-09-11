class Token < ActiveRecord::Base
  belongs_to :user
  uniquify :value
  has_friendly_id :value
end
