class TokensController < InheritedResources::Base
  respond_to :json

  def show
    render :json => resource, :include => :user
  end
end
