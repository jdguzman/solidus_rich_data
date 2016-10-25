module Spree
  module SpreeRichData
    module RichDataHelper
      include ActionView::Helpers::TagHelper
      SOCIAL_ENTITIES = [:twitter_url, :facebook_url, :linkedin_url, :pinterest_url].freeze

      def social_title
        Spree.t('rich_data.social_title.default', site: current_store.name)
      end

      def social_description
        Spree.t('rich_data.social_description.default', site: current_store.name)
      end

      private

      def external_urls
        SOCIAL_ENTITIES.collect do |item|
          current_store.send(item)
        end.compact
      end
    end
  end
end
