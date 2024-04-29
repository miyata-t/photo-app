class TweetsController < ApplicationController
  def create
    begin
      photo = Photo.find_by!(id: params[:photo_id], user_id: current_user.id)
    rescue ActiveRecord::RecordNotFound
      flash[:error] = '存在しない画像をツイートしようとしています'
      redirect_to photos_path
    end
    settings = Rails.application.config_for(:setting, env: Rails.env)[:photo_app]
    client = MyTweetHttpClient.new
    client.tweet_request(title: photo.title, image_url: settings[:base_url] + photo.image_path, access_token: session[:access_token])

    flash[:notice] = 'ツイートに成功しました。'
    redirect_to photos_path
  rescue MyTweetHttpClient::ClientError => e
    logger.error "error message: #{e.message}"

    flash[:error] = 'ツイートに失敗しました。'
    redirect_to photos_path
  end
end
