class SessionsController < Devise::SessionsController
  respond_to :json
  after_filter :create_cookie, :only => :create
  after_filter :destroy_cookie, :only => :destroy

  def show
    respond_with Session.find(params[:id])
  end

  protected

  def create_cookie
    cookies[:ssophia] = '94n73cv5p43c58mv934'
  end

  def destroy_cookie
    cookies.delete :ssophia
  end

  def require_no_authentication
    session[:return_url] ||= request_return_url
    super
  end

  def after_sign_in_path_for(resource_or_scope)
    if return_url = session_return_url
      "#{return_url}?token=#{token}"
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    params[:returnURL] || root_path
  end

  def token
    current_user.new_token_value
  end

  def session_id
    cookies["_session_id"]
  end

  def request_return_url
    params[:returnURL]
  end

  def session_return_url
    session.delete :return_url
  end
end

