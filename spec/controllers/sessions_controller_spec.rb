require "spec_helper"

describe SessionsController do
  include Devise::TestHelpers

  context "with a logged user" do
    let(:url) { 'http://www.mouseoverstudio.com' }
    let(:user) { Factory(:user) }

    before :each do
      sign_in user
      controller.stub(:devise_mapping).and_return(Devise.mappings[:user])
    end

    it "should redirect to the url specified by 'returnURL'" do
      get :new, :returnURL => url
      response.headers['Location'].should be_start_with(url)
    end

    it "should include an users token as a query string parameter called 'token' when redirecting the user" do
      get :new, :returnURL => url
      Token.find(response.headers['Location'].gsub("#{url}?token=", '')).user.should eql(user)
    end
  end
end
