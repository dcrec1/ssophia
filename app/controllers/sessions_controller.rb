class SessionsController < Devise::SessionsController
  include SingleSignOn
  respond_to :json
  after_filter :create_cookie, :only => :create
  after_filter :destroy_cookie, :only => :destroy

  def show
    respond_with Session.find(params[:id])
  end

  private

  def after_sign_in_path_for(resource_or_scope)
    return_url
  end

  def after_sign_out_path_for(resource_or_scope)
    params[:returnURL] || root_path
  end
end

