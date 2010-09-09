class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :store_return_url

  private

  def store_return_url
    session[:return_url] ||= params[:returnURL]
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:return_url] || params[:returnURL]
  end
end
