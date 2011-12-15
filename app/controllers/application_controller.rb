class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  protected
  
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

    def render_not_found(exception = nil)
      render :file => "#{Rails.root}/public/404.html", :status => :not_found
    end
    
end
