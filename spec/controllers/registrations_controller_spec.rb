require 'spec_helper'

describe RegistrationsController do
  include Devise::TestHelpers

  let(:url) { 'http://www.mouseoverstudio.com' }

  before :each do
    controller.stub(:devise_mapping).and_return(Devise.mappings[:user])
  end

  context "on signup" do
    let(:user) { Factory.build :user } 

    it "should create a ssophia cookie" do
      post :create, :user => { :email => user.email, :password => user.password, :password_confirmation => user.password }
      cookies['ssophia'].should_not be_nil
    end

    it "should create each time a different ssophia cookie" do
      post :create, :user => { :email => user.email, :password => user.password, :password_confirmation => user.password }
      cookie = cookies['ssophia']
      post :create, :user => { :email => "fake@email.com", :password => user.password }
      cookie.should_not eql(cookies['ssophia']) 
    end
  end
end
