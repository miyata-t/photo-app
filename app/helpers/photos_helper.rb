module PhotosHelper
  def my_tweet_app_auth_url
    settings = Rails.application.config_for(:setting, env: Rails.env)[:my_tweet]

    "#{settings[:base_url]}#{settings[:authorization_path]}?response_type=code&client_id=#{settings[:client_id]}&redirect_uri=#{settings[:redirect_uri]}&scope=write_tweet"
  end
end
