class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_login
    redirect_to login_path unless login?
  end
end
