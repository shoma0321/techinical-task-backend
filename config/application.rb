require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Nextapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:3000', 'https://technical-task-henna.vercel.app'# ここにはクライアントのオリジンを指定します

        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
  end
end
