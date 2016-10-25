Spree::Admin::GeneralSettingsController.class_eval do
  [:social_image_url, :show_entity_markup, :facebook_id,
   :twitter_id, :facebook_url, :linkedin_url, :pinterest_url,
   :twitter_url].each do |a|
    Spree::PermittedAttributes.store_attributes << a
  end
end
