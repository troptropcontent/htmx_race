class ApplicationController < ActionController::Base
    with_options unless: :devise_controller? do |controller|
        controller.before_action :authenticate_user!
        controller.load_and_authorize_resource
    end
end
