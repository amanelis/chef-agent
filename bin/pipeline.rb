# Module namespace for deployment
# Examples:
#   Pipeline::Utility::PaperTrail.generate_papertrail_id "10.43.45.21"
module Pipeline
  module ClassMethods
    def logger=(logger)
      @logger = logger
    end
    
    def logger
      @logger ||= Logger.new(STDERR)
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  # Utility
  #
  # Description: ment to house over used code and utility methods.
  module Utility
    class AWS
      class << self
      end
    end
    
    class PaperTrail
      class << self
        
        # generate_papertrail_id
        # description: used to build a papertrail ID from an aws private_ip address(dns_name).
        # @param: String[private_dns_name] - "10.32.31.5"
        # @return: String[ip-10.32.32.5]
        def generate_papertrail_id private_dns_name
          private_dns_name.nil? || private_dns_name.eql?("") ? "" : "ip-" + private_dns_name.gsub('.','-')
        end
        
        # deregister!
        # description: used to deregister and remove an instance from the papertrail dashbaord.
        #   list can grow if these are not properly cleaned up.
        # @param: String[id] - "ip-10-60-51-29"
        # @return: Boolean - based on success of deregister
        def deregister! id, token
          return false if id.nil? || token.nil?
          begin 
            response = Timeout.timeout(10) do
              `curl -i -H "X-Papertrail-Token: #{token}" -X DELETE "https://papertrailapp.com/api/v1/systems/#{id}.json" | grep -c 200`.strip
            end
          rescue Timeout::Error => e
            puts "Timeout Error: deregister on papertrail => #{e}"
            return false
          end
          return !Integer(response).zero?
        end
      end
    end
  end
end
