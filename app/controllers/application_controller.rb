class AccessDenied < RuntimeError
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from AccessDenied do |exception|
    render status: 403, text: 'AccessDenied'
  end
end
