require 'net/http'

class MyTweetHttpClient
  attr_reader :settings, :base_url, :client_id, :client_secret, :redirect_uri

  def initialize
    @settings = Rails.application.config_for(:setting, env: Rails.env)[:my_tweet]
    @base_url = settings[:base_url]
    @client_id = settings[:client_id]
    @client_secret = settings[:client_secret]
    @redirect_uri = settings[:redirect_uri]
  end

  def access_token_request(code:)
    uri = URI.parse(base_url + settings[:access_token_path])
    params = { grant_type: 'authorization_code', code:, client_id:, client_secret:, redirect_uri: }
    res = Net::HTTP.post_form(uri, params)
    JSON.parse(res.body)['access_token']
  rescue => e
    Rails.logger.error "アクセストークン取得リクエストでエラーが起きました。ErrorClass: #{e.class}, backtrace: #{e.backtrace}"

    raise e
  end
end
