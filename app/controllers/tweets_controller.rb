class TweetsController < ApplicationController
  def create
    client = MyTweetHttpClient.new
    client.tweet_request(title: params[:title], image_url: params[:image_url], access_token: session[:access_token])

    redirect_to photos_path
  rescue MyTweetHttpClient::ClientError => e
    logger.error "error message: #{e.message}"

    redirect_to photos_path
  end
end
