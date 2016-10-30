class AccessDenied < RuntimeError
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # rescue_from AccessDenied do |exception|
  #   render status: 403, text: 'AccessDenied'
  # end

  private

    def require_admin
      resource_name = controller_name.singularize
      instance = instance_variable_get("@#{resource_name}")
      if @decision
        id = @decision.id
      elsif instance
        id = instance.decision_id
      else
        id = params[:decision_id] || params[resource_name][:decision_id]
      end
      @membership = current_user.memberships.find_by!(decision_id: id)
      raise AccessDenied unless @membership.owner?
    end
end
