class TweetsController < ApplicationController
  def create
    client = MyTweetHttpClient.new
    client.tweet_request(title: params[:title], image_url: params[:image_url], access_token: session[:access_token])

    flash[:notice] = 'ツイートに成功しました。'
    redirect_to photos_path
  rescue MyTweetHttpClient::ClientError => e
    logger.error "error message: #{e.message}"

    flash[:error] = 'ツイートに失敗しました。'
    redirect_to photos_path
  end
end
