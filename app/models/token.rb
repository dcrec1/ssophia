class Token < ActiveRecord::Base
  belongs_to :user
  uniquify :value
end
