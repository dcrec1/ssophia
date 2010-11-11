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
    let(:user) { Factory :user } 

    it "should create a ssophia cookie" do
      post :create, :user => { :email => user.email, :password => user.password }
      cookies['ssophia'].should_not be_nil
    end

    it "should create each time a different ssophia cookie" do
      post :create, :user => { :email => user.email, :password => user.password }
      cookie = cookies['ssophia']
      post :create, :user => { :email => user.email, :password => user.password }
      cookie.should_not eql(cookies['ssophia']) 
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

    it "should destroy the ssophia cookie" do
      controller.send(:cookies)['ssophia'] = "945u4038hf403g43b"
      get :destroy
      cookies['ssophia'].should be_nil
    end
  end
end
