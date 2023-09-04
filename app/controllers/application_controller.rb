class ApplicationController < ActionController::Base
  def current_user
    @user = User.find(params[:user_id])
    @user
  end

  helper_method :current_user
end
