class SessionsController < Devise::SessionsController
  def require_no_authentication
    session[:return_url] ||= params[:returnURL]
    super
  end

  def after_sign_in_path_for(resource_or_scope)
    "#{return_url}?token=#{token}"
  end

  def after_sign_out_path_for(resource_or_scope)
    params[:returnURL]
  end

  private

  def token
    current_user.new_token_value
  end

  def return_url
    session[:return_url]
  end
end
