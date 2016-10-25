module SolidusRichData
  class Engine < Rails::Engine
    require 'spree/core'
    require_relative 'meta_tags'
    require_relative 'rich_data_helper'
    isolate_namespace Spree
    engine_name 'solidus_rich_data'

    initializer "spree.rich_data.environment", before: :load_config_initializers do
      Spree::RichData::Config = Spree::RichDataConfiguration.new
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
