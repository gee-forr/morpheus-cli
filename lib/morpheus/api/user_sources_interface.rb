require 'morpheus/api/api_client'

class Morpheus::UserSourcesInterface < Morpheus::APIClient
    def initialize(access_token, refresh_token, expires_at = nil, base_url=nil) 
    @access_token = access_token
    @refresh_token = refresh_token
    @base_url = base_url
    @expires_at = expires_at
  end

  def get(account_id, id)
    raise "#{self.class}.get() passed a blank id!" if id.to_s == ''
    url = build_url(account_id, id)
    headers = { params: {}, authorization: "Bearer #{@access_token}" }
    opts = {method: :get, url: url, timeout: 10, headers: headers}
    execute(opts)
  end

  def list(account_id, options={})
    url = build_url(account_id)
    headers = { params: {}, authorization: "Bearer #{@access_token}" }
    headers[:params].merge!(options)
    opts = {method: :get, url: url, timeout: 10, headers: headers}
    execute(opts)
  end

  def create(account_id, options)
    url = build_url(account_id)
    headers = { :authorization => "Bearer #{@access_token}", 'Content-Type' => 'application/json' }
    payload = options
    opts = {method: :post, url: url, timeout: 10, headers: headers, payload: payload.to_json}
    execute(opts)
  end

  def update(account_id, id, options)
    url = build_url(account_id, id)
    headers = { :authorization => "Bearer #{@access_token}", 'Content-Type' => 'application/json' }
    payload = options
    opts = {method: :put, url: url, timeout: 10, headers: headers, payload: payload.to_json}
    execute(opts)
  end

  def destroy(account_id, id)
    url = build_url(account_id, id)
    headers = { :authorization => "Bearer #{@access_token}", 'Content-Type' => 'application/json' }
    opts = {method: :delete, url: url, timeout: 10, headers: headers}
    execute(opts)
  end

  def activate(account_id, id, options)
    url = build_url(account_id, id) + "/activate"
    headers = { :authorization => "Bearer #{@access_token}", 'Content-Type' => 'application/json' }
    payload = options
    opts = {method: :put, url: url, timeout: 10, headers: headers, payload: payload.to_json}
    execute(opts)
  end

  def deactivate(account_id, id, options)
    url = build_url(account_id, id) + "/deactivate"
    headers = { :authorization => "Bearer #{@access_token}", 'Content-Type' => 'application/json' }
    payload = options
    opts = {method: :put, url: url, timeout: 10, headers: headers, payload: payload.to_json}
    execute(opts)
  end

  def update_subdomain(account_id, id, options)
    url = build_url(account_id, id) + "/subdomain"
    headers = { :authorization => "Bearer #{@access_token}", 'Content-Type' => 'application/json' }
    payload = options
    opts = {method: :put, url: url, timeout: 10, headers: headers, payload: payload.to_json}
    execute(opts)
  end

  # move me to my own interface class
  def list_types(params={})
    url = "#{@base_url}/api/user-source-types"
    headers = { params: params, authorization: "Bearer #{@access_token}" }
    opts = {method: :get, url: url, timeout: 10, headers: headers}
    execute(opts)
  end

  # move me to my own interface class
  def get_type(id, params={})
    url = "#{@base_url}/api/user-source-types/#{id}"
    headers = { params: params, authorization: "Bearer #{@access_token}" }
    opts = {method: :get, url: url, timeout: 10, headers: headers}
    execute(opts)
  end

  private

  def build_url(account_id=nil, user_id=nil)
    url = "#{@base_url}/api"
    if account_id
      url += "/accounts/#{account_id}/user-sources"
    else
      url += "/user-sources"
    end
    if user_id
      url += "/#{user_id}"
    end
    url
  end

end
