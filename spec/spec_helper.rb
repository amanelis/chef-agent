# Required libs/gems
require 'webmock'
require 'webmock/rspec'
require 'capybara/rspec'

# Require classes for testing
require 'bin/pipeline'

RSpec.configure do |config|
  # Mock Framework
  config.mock_with :rspec
  
  # Use WebMock on any http request
  config.include WebMock::API
  
  # Capybara for integrations
  config.include Capybara::DSL

  # Capybara configuration
  Capybara.javascript_driver = :selenium_remote_firefox
  
  # WebMock Configuration
  config.before do
    WebMock.enable!
    if Capybara.current_driver != :rack_test
      selenium_requests = %r{/((__.+__)|(hub/session.*))$}
      WebMock.disable_net_connect! :allow => selenium_requests
      WebMock.disable_net_connect! :allow => '127.0.0.1:#{Capybara.current_session.driver.server_port}' # this only works for capybara selenium and capybara-webkit
    else
      WebMock.disable_net_connect!
    end
  end

  # for connections where we need to have network access we just tag it network
  config.before(:each, :network => true) do
    WebMock.disable!
  end
end