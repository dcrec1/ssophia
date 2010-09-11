def should_have_an_slugged_id(name)
  it "should be found by the slugged #{name} as an id" do
    clazz = subject.class
    object = Factory(clazz.to_s.underscore, name => "Hello World")
    clazz.find(object.id).should == clazz.find("hello-world")
  end
end

def should_require_authentication_on_private_actions
  include Devise::TestHelpers

  context "without a logged user" do
    describe "GET index" do
      it "should return 200 as the status code" do
        get :index
        response.code.should eql("200")
      end
    end

    describe "POST create" do
      it "should return 302 as the status code"  do
        post :create
        response.code.should eql("302")
      end
    end

    describe "PUT update" do
      it "should return 302 as the status code"  do
        put :update, :id => 10
        response.code.should eql("302")
      end
    end

    describe "DELETE destroy" do
      it "should return 302 as the status code" do
        delete :destroy, :id => 20
        response.code.should eql("302")
      end
    end
  end
end

def should_require_authentication
  include Devise::TestHelpers

  context "without a logged user" do
    describe "GET index" do
      it "should return 302 as the status code"  do
        get :index
        response.code.should eql("302")
      end
    end
  end

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
    end

    describe "GET index" do
      it "should return 200 as the status code"  do
        get :index
        response.code.should eql("200")
      end
    end
  end
end

def should_require_admin_authentication
  include Devise::TestHelpers

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
    end

    describe "GET index" do
      it "should return 302 as the status code"  do
        get :index
        response.code.should eql("302")
      end
    end
  end

  context "with a logged admin" do
    before :each do
      sign_in Factory(:admin)
    end

    describe "GET index" do
      it "should return 200 as the status code"  do
        get :index
        response.code.should eql("200")
      end
    end
  end
end

def should_require_admin_authentication_on_private_actions
  include Devise::TestHelpers

  context "with a logged user" do
    before :each do
      sign_in Factory(:user)
    end

    describe "GET index" do
      it "should return 200 as the status code" do
        get :index
        response.code.should eql("200")
      end
    end

    describe "POST create" do
      it "should return 302 as the status code"  do
        post :create
        response.code.should eql("302")
      end
    end

    describe "PUT update" do
      it "should return 302 as the status code"  do
        put :update, :id => 10
        response.code.should eql("302")
      end
    end

    describe "DELETE destroy" do
      it "should return 302 as the status code" do
        delete :destroy, :id => 20
        response.code.should eql("302")
      end
    end

    describe "GET new" do
      it "should return 302 as the status code" do
        get :new
        response.code.should eql("302")
      end
    end

    describe "GET edit" do
      it "should return 302 as the status code" do
        get :edit, :id => 10
        response.code.should eql("302")
      end
    end
  end
end

def should_have_only_public_actions
  %w(index show).each do |action|
    it "should respond to GET #{action}" do
      subject.should respond_to(action)
    end
  end

  %w(edit update destroy).each do |action|
    it "should not respond to #{action}" do
      subject.should_not respond_to(action)
    end
  end
end
