require 'json'
require 'morpheus/rest_client'

class Morpheus::ProvisionTypesInterface < Morpheus::APIClient
	def initialize(access_token, refresh_token,expires_at = nil, base_url=nil) 
		@access_token = access_token
		@refresh_token = refresh_token
		@base_url = base_url
		@expires_at = expires_at
	end

	def get(options=nil)
		url = "#{@base_url}/api/provision-types"
		headers = { params: {}, authorization: "Bearer #{@access_token}" }

		if options.is_a?(Hash)
			headers[:params].merge!(options)
		elsif options.is_a?(Numeric)
			url = "#{@base_url}/api/provision-types/#{options}"
		elsif options.is_a?(String)
			headers[:params]['name'] = options
		end
		response = Morpheus::RestClient.execute(method: :get, url: url,
                            timeout: 30, headers: headers, verify_ssl:false)
		JSON.parse(response.to_s)
	end
end