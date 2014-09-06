require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module LemonBaseSystemmanager
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('lib', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :cn
    config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir["#{Rails.root}/app/api/*"]
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        # location of your API
        resource '/api/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
      end
    end
    # config.autoload_paths += Dir[Rails.root.join('app', 'api', '*').to_s]

    # platform = RUBY_PLATFORM.match(/(linux|darwin)/)[0].to_sym
    # Bundler.require(platform)
  end
end
