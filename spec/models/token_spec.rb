require 'spec_helper'

describe Token do
  should_belong_to :user
  should_validate_presence_of :user

  it "should be created with an unique token" do
    Factory(:token).value.should_not eql(Factory(:token).value)
  end

  it "should be found by the value" do
    value = Factory(:token).value 
    Token.find(value).should_not be_nil
  end
end
