class RegistrationsController < Devise::RegistrationsController
  include SingleSignOn
  after_filter :create_cookie, :only => :create

  private

  def stored_location_for(resource_or_scope)
    return_url
  end
end
