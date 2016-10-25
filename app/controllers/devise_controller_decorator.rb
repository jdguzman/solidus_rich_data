DeviseController.class_eval do
  include Spree::SpreeRichData::RichDataHelper
  helper_method :social_title, :social_description, :external_urls
end