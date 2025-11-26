require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

module SampleApp
  class Application < Rails::Application
    config.load_defaults 7.1
    config.eager_load = false
    config.api_only = true
  end
end
