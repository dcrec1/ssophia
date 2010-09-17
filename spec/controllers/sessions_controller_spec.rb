require "spec_helper"

describe SessionsController do
  include Devise::TestHelpers

  let(:url) { 'http://www.mouseoverstudio.com' }

  before :each do
    controller.stub(:devise_mapping).and_return(Devise.mappings[:user])
  end

  context "with a logged user" do
    let(:user) { Factory(:user) }

    before :each do
      sign_in user
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

  context "on logout" do
    it "should redirect to the url specified by 'returnURL'" do
      get :destroy, :returnURL => url
      response.should redirect_to(url)
    end

    it "should reditect to the root path if the return url was not specified" do
      get :destroy
      response.should redirect_to(root_path)
    end
  end
end
