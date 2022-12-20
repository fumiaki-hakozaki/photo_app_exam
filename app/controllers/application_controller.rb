class ApplicationController < ActionController::Base
    protect_form_forgery with: :exceotion
    include SessionsHelper
    before_action :login_required

    private

    def login_required
        redirect_to new_session_path unless current_user
    end
end
