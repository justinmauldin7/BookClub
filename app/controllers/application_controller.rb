class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActionController::RoutingError do |exception|
    flash[:error] = ""
    redirect_to root_path
  end
  
end
