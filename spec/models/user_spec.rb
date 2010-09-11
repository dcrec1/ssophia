require 'spec_helper'

describe User do
  should_have_many :tokens
end
