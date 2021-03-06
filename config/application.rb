require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CharliePooped
  class Application < Rails::Application
    config.action_controller.permit_all_parameters = true
    config.time_zone = 'Eastern Time (US & Canada)'
  end
end
