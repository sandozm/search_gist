class Gist < ActiveRecord::Base
	def APIGist(uri, search = nil)
		require 'net/http'
		require 'json'

		uri = URI(uri)
		req = Net::HTTP::Get.new(uri.to_s)
		req.basic_auth("sandozmtemp", "azerty00")

		Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
			response = http.request(req)
			res = JSON.parse(response.body)

			if search != nil
				search = search.upcase
				res.each_with_index do |k, index|

					if k['description'].to_s.upcase !~ /#{search}/
						k['owner'] = nil
					end
				end
			end
			return res;
		end
	end
end
