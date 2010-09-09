require 'spec_helper'

describe Token do
  should_belong_to :user
  should_validate_presence_of :value
end
