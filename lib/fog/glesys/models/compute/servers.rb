require 'fog/core/collection'
require 'fog/glesys/models/compute/server'

module Fog
  module Compute
    class Glesys

        class Servers < Fog::Collection

        model Fog::Compute::Glesys::Server

        def all
          data = service.list_servers.body['response']['servers']
          load(data)
        end

        def get(identifier)
          return nil if identifier.nil? || identifier == ""

          begin
            details = service.server_details(identifier).body['response']
            status  = service.server_status(identifier).body['response']

            if details.empty? || status.empty?
              nil
            else
              status['server'].merge!({ :serverid => identifier})
              details['server'].merge!(status['server'])
              new(details['server'])
            end
          rescue
            return nil
          end
        end

      end

    end
  end
end
