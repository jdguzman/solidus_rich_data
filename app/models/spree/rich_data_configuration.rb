module Spree
  class RichDataConfiguration < Preferences::Configuration
    preference :store_uses_https, :boolean, default: false
  end
end
