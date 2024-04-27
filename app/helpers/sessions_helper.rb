module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound => e
    logger.error "ユーザーが見つかりませんでした。user_id: #{session[:user_id]}"
    nil
  end

  def login?
    current_user.present?
  end

  def logout
    session.delete(:user_id)
    session.delete(:access_token)
  end
end
