require 'spec_helper'

describe TokensController do
  context "GET show" do
    context "with json format" do
      it "should serialize a token" do
        token = Factory(:token)
        get :show, :id => token.value, :format => :json
        response.body.should eql(token.to_json)
      end
    end
  end
end
