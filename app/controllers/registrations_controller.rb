class RegistrationsController < Devise::RegistrationsController
  after_filter :create_cookie, :only => :create

  private

  def create_cookie
    cookies[:ssophia] = random_string
  end

  def random_string
    (0...8).map{65.+(rand(25)).chr}.join 
  end
end
