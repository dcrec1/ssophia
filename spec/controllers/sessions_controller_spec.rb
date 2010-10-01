require "spec_helper"

describe SessionsController do
  include Devise::TestHelpers

  let(:url) { 'http://www.mouseoverstudio.com' }

  before :each do
    controller.stub(:devise_mapping).and_return(Devise.mappings[:user])
  end

  context "on GET show" do
    context "with json format" do 
      it "should render the session as json" do
        session = Factory :session
        get :show, :id => session.id, :format => 'json'
        response.body.should eql(session.to_json)
      end
    end
  end

  context "with a logged user" do
    let(:user) { Factory(:user) }

    before :each do
      sign_in user
    end

    it "should redirect to the url specified by 'returnURL' if specified" do
      get :new, :returnURL => url
      response.headers['Location'].should be_start_with(url)
    end

    it "should redirect to the root path 'returnURL' was not specified" do
      get :new
      response.should redirect_to(root_path)
    end

    it "should include an users token as a query string parameter called 'token' when redirecting the user" do
      get :new, :returnURL => url
      Token.find(response.headers['Location'].gsub("#{url}?token=", '')).user.should eql(user)
    end

    it "should use the returnURL only once" do
      get :new, :returnURL => url
      get :new
      response.headers['Location'].should_not be_start_with(url)
    end
  end

  context "on login" do
    let(:session_id) { "54334g34g4g3g34" }

    before :each do
      controller.stub(:cookies).and_return("_session_id" => session_id)
    end

    it "should create a session for the user" do
      user = Factory :user
      post :create, :user => { :email => user.email, :password => user.password }
      Session.find(session_id).should_not be_nil
    end
  end

  context "on logout" do
    before :each do
      controller.stub(:cookies).and_return("_session_id" => Factory(:session).session_id)
    end

    it "should redirect to the url specified by 'returnURL'" do
      get :destroy, :returnURL => url
      response.should redirect_to(url)
    end

    it "should reditect to the root path if the return url was not specified" do
      get :destroy
      response.should redirect_to(root_path)
    end

    it "should destroy the user session" do
      get :destroy
      Session.count.should == 0
    end

    it "should not destroy other user's session" do
      session = Factory :session
      get :destroy
      Session.find(session.id).should_not be_nil
    end

    it "should ignore if the session doesnt exist" do
      Session.destroy_all
      get :destroy
      controller.should_not be_user_signed_in
    end
  end
end
