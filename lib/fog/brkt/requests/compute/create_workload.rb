module Fog
  module Compute
    class Brkt
      class Real
        def create_workload(billing_group_id, name, zone, options={})
          request(
            :expects => [201],
            :method  => "POST",
            :path    => "v2/api/config/workload",
            :body    => Fog::JSON.encode({
              :billing_group => billing_group_id,
              :name          => name,
              :zone          => zone
            }.merge(options))
          )
        end
      end

      class Mock
        def create_workload(billing_group_id, name, zone, options={})
          response = Excon::Response.new
          id = Fog::Brkt::Mock.id
          data = {
            "billing_group"       => billing_group_id,
            "created_by"          => "user@brkt.com",
            "created_time"        => "2014-05-20T19:56:58.782760+00:00",
            "customer"            => "2b86ea2c4637408389c8aee9269d7b10",
            "deleted"             => false,
            "description"         => options[:description],
            "expired"             => false,
            "id"                  => id,
            "instances"           => "/v1/api/config/workload/#{id}/instances",
            "lease_expire_time"   => "2014-05-20T19:56:58.782760+00:00",
            "lease_modified_time" => "2014-05-20T19:56:58.782760+00:00",
            "max_cost"            => "1000.00",
            "modified_by"         => "user@brkt.com",
            "modified_time"       => "2014-05-20T19:56:58.782760+00:00",
            "name"                => name,
            "requested_state"     => "AVAILABLE",
            "service_domain"      => "example-workload",
            "state"               => "INITIALIZING",
            "workload_template"   => "eb9da135292646608e238aa043e90081",
            "zone"                => zone
          }
          self.data[:workloads][id] = data
          response.body = data
          response
        end
      end
    end
  end
end
