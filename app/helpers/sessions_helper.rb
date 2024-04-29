module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    return @current_user if instance_variable_defined?(:@current_user)

    @current_user = session[:user_id] ? User.find(session[:user_id]) : nil
  rescue ActiveRecord::RecordNotFound
    logger.error "ユーザーが見つかりませんでした。user_id: #{session[:user_id]}"
    @current_user = nil
  end

  def login?
    current_user.present?
  end

  def logout
    session.delete(:user_id)
    session.delete(:access_token)
  end

  def authenticated?
    session[:access_token].present?
  end
end
