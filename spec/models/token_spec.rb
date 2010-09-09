require 'spec_helper'

describe Token do
  should_belong_to :user

  it "should be created with an unique token" do
    Token.create!.value.should_not eql(Token.create!.value)
  end
end
