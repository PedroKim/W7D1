class ApplicationController < ActionController::Base
    helper_method :current_user

    def login!(user)
        @current_user = user
        session[:session_token] = user.session_token
        if user.session_tokens.find_by(session_token: user.session_token).nil?
            user.session_tokens.create!(session_token: user.session_token)
        end
    end

    def logout!
        current_user.try(:reset_session_token!)
        session[:session_token] = nil
    end

    def current_user
        return nil if session[:session_token].nil?
        @current_user ||= SessionToken.find_by(session_token: session[:session_token]).user
        # @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def cat_owner?(user)
        target_cat = user.cats.find_by(id: params[:id])
        !target_cat.nil?
    end

    def require_current_user!
        redirect_to new_session_url if current_user.nil?
    end

    def require_correct_user!
        if cat_owner?(current_user)
            flash[:errors] = ["You can't edit this cat"]
            redirect_to cats_url
        end
    end

    def exists_current_user!
        redirect_to cats_url unless current_user.nil?
    end
end
