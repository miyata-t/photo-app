require 'net/http'

class MyTweetHttpClient
  class ClientError < StandardError; end

  attr_reader :settings, :base_url, :client_id, :client_secret, :redirect_uri

  def initialize
    @settings = Rails.application.config_for(:setting)[:my_tweet]
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

  def tweet_request(title:, image_url:, access_token:)
    uri = URI.parse(base_url + settings[:tweet_path])
    headers = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{access_token}" }
    params = { text: title, url: image_url }
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = false
    res = http.post(uri.path, params.to_json, headers)
    raise ClientError.new("成功以外のレスポンスが返されました。status_code: #{res.code}, message: #{res.message}") if res.code != "201"
  rescue ClientError => e
    raise e
  rescue StandardError => e
    Rails.logger.error "ツイートに失敗しました。ErrorClass: #{e.class}, backtrace: #{e.backtrace}"

    raise e
  end
end
