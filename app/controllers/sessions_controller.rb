class SessionsController < Devise::SessionsController
  def require_no_authentication
    session[:return_url] ||= params[:returnURL]
    super
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:return_url]
  end
end
