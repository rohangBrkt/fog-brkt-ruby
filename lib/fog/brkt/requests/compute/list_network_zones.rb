module Fog
  module Compute
    class Brkt
      class Real
        def list_network_zones(network_id)
          request(
            :expects => [200],
            :path    => "v1/api/config/network/#{network_id}/zones"
          )
        end
      end

      class Mock
        def list_network_zones(network_id)
          response = Excon::Response.new
          response.body = self.data[:zones].map { |id, zone_data| zone_data }
          response
        end
      end
    end
  end
end
