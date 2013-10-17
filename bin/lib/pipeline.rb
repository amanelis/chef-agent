# Module namespace for deployment
# Examples:
#   Pipeline::Utility::PaperTrail.generate_papertrail_id "10.43.45.21"
module Pipeline
  module ClassMethods
    def logger
      @logger ||= Logger.new(STDOUT)
    end
    
    def logger=(logger)
      @logger = logger
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  class Basement
    include Pipeline
  end
  
  def self.info val
    Basement.logger = val
  end

  # Utility
  #
  # Description: ment to house over used code and utility methods.
  module Utility
    class AWS
      class << self
      end
    end
    
    class Dependencies
      class << self
        def install_main_dependencies!
          begin 
            orig_stdout = $stdout.dup
            $stdout.reopen('/dev/null', 'w')

            system("gem install aws-sdk --no-ri --no-rdoc") unless system("gem list | grep aws-sdk")
            system("gem install net-ssh --no-ri --no-rdoc") unless system("gem list | grep net-ssh")
          ensure
            $stdout.reopen(orig_stdout)
          end
        end
        
        def require_stdlibs
          require 'rubygems'
          require 'open3'
          require 'optparse'
          require 'timeout'
          require 'yaml'
        end
        
        def require_third_party
          require 'aws-sdk'
          require 'net/ssh'
        end
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
        #   List can grow if these are not properly cleaned up.
        # @param: String[id] - "ip-10-60-51-29"
        # @param: String[token] - 208ghrhg028hg2
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
        
        # deregister_by_aws_private_ip_address!
        # description: used to deregister and remove an instance from the papertrail dashbaord.
        #   List can grow if these are not properly cleaned up.
        # @param: String[id] - "ip-10-60-51-29"
        # @param: String[token] - 208ghrhg028hg2
        # @return: Boolean - based on success of deregister
        def deregister_by_aws_private_ip_address! private_ip_address, token
          return false if private_ip_address.nil? || token.nil?
          begin 
            response = Timeout.timeout(10) do
              `curl -i -H "X-Papertrail-Token: #{token}" -X DELETE "https://papertrailapp.com/api/v1/systems/#{self.generate_papertrail_id private_ip_address}.json" | grep -c 200`.strip
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