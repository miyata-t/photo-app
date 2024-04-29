class OauthController < ApplicationController
  def callback
    client = MyTweetHttpClient.new
    access_token = client.access_token_request(code: params[:code])
    session[:access_token] = access_token

    redirect_to photos_path
  end
end
