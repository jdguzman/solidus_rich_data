class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    begin
      uri = URI.parse(value)
      response = uri.is_a?(URI::HTTP)
    rescue URI::InvalidURIError
      response = false
    end
    unless response
      record.errors[attribute] << (options[:message] || 'is not a URL')
    end
  end
end
