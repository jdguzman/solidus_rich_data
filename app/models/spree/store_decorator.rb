Spree::Store.class_eval do
  validates :social_image_url, url: true
  validates :facebook_url, url: true
  validates :twitter_url, url: true
  validates :linkedin_url, url: true
  validates :pinterest_url, url: true

  validates :facebook_id, numericality: { only_integer: true, allow_blank: true }
  validates :twitter_id, numericality: { only_integer: true, allow_blank: true}

  def url_with_protocol(path = '')
    protocol = https? ? 'https' : 'http'
    protocol + "://#{url}#{path}"
  end

  def https?
    Spree::RichData::Config[:store_uses_https]
  end

  def twitter_name
    return unless twitter_url.present?
    twitter_url.split('/').last.insert(0, '@')
  end
end
