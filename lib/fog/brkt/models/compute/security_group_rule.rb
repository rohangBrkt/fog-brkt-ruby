require "fog/core/model"

module Fog
  module Compute
    class Brkt
      class SecurityGroupRule < Fog::Model
        identity :id

        attribute :cidr_ip
        attribute :ip_proto
        attribute :port_range_from, :type => :integer
        attribute :port_range_to, :type => :integer
        attribute :description
        attribute :security_group

        def save
          requires :security_group, :cidr_ip, :ip_proto, :port_range_from, :port_range_to

          data = service.create_security_group_rule(security_group, attributes).body
          merge_attributes(data)

          true
        end

        def destroy
          requires :id

          service.delete_security_group_rule(id)
          true
        end
      end
    end
  end
end
