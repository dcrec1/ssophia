require "spec_helper"

describe SessionsController do
  include Devise::TestHelpers

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
      controller.stub(:devise_mapping).and_return(Devise.mappings[:user])
    end

    it "should redirect to the url specified by 'returnURL'" do
      url = 'http://www.mouseoverstudio.com' 
      get :new, :returnURL => url
      response.should redirect_to(url)
    end
  end
end
