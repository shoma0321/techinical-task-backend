require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Nextapp
  class Application < Rails::Application
    config.load_defaults 7.0
    
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:3000',
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
  end
end
