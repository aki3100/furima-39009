require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Furima39009
  class Application < Rails::Application
    config.load_defaults 6.0

#    Rails.application.config.i18n.default_locale = :ja
#    Faker::Config.locale = :ja

  end
end
