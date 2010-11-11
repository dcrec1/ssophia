module SingleSignOn
  def return_url
    if return_url = session_return_url
      "#{return_url}?token=#{token}"
    else
      root_path
    end
  end

  def require_no_authentication
    session[:return_url] ||= request_return_url
    super
  end

  def create_cookie
    cookies[:ssophia] = random_string
  end

  def destroy_cookie
    cookies.delete :ssophia
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

  def random_string
    (0...8).map{65.+(rand(25)).chr}.join 
  end
end
