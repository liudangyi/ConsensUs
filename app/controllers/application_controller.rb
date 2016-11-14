class AccessDenied < RuntimeError
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :disable_layout_when_xhr

  # rescue_from AccessDenied do |exception|
  #   render status: 403, text: 'AccessDenied'
  # end

  private

    def disable_layout_when_xhr
      request.xhr? ? false : nil
    end

    def require_admin
      if @current_membership.nil?
        resource_name = controller_name.singularize
        instance = instance_variable_get("@#{resource_name}")
        if @decision
          id = @decision.id
        elsif instance
          id = instance.decision_id
        else
          id = params[:decision_id] || params[resource_name][:decision_id]
        end
        @current_membership = current_user.memberships.find_by!(decision_id: id)
      end
      raise AccessDenied unless @current_membership.owner?
    end
end
