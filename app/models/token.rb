class Token < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :value
end
