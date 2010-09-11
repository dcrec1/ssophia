class SessionsController < Devise::SessionsController
  def require_no_authentication
    session[:return_url] ||= request_return_url
    super
  end

  def after_sign_in_path_for(resource_or_scope)
    "#{session_return_url}?token=#{token}"
  end

  def after_sign_out_path_for(resource_or_scope)
    params[:returnURL]
  end

  private

  def token
    current_user.new_token_value
  end

  def request_return_url
    params[:returnURL]
  end

  def session_return_url
    session[:return_url]
  end
end
