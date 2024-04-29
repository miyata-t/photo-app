class SessionsController < ApplicationController
  before_action :logged_in, only: %i[new create]

  def new; end

  def create
    user_name = login_params[:name]
    password = login_params[:password]

    @errors = []
    @errors << 'ユーザーIDが未入力です' if user_name.blank?
    @errors << 'パスワードが未入力です' if password.blank?

    return render :new, status: :unprocessable_entity if @errors.present?

    begin
      user = User.find_by!(name: user_name)
    rescue ActiveRecord::RecordNotFound
      @errors << 'ユーザーIDもしくはパスワードが誤っています'
      return render :new, status: :unprocessable_entity
    end

    if user && user.authenticate(password)
      login(user)
      redirect_to photos_path
    else
      @errors << 'ユーザーIDもしくはパスワードが誤っています'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other
  end

  private

  def login_params
    params.permit(:name, :password)
  end

  def logged_in
    redirect_to photos_path if login?
  end
end
