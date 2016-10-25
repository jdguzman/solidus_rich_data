# Author::    Maurizio Casimirri (mailto:maurizio.cas@gmail.com)
# Copyright:: Copyright (c) 2012 Maurizio Casimirri
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module MetaTagsHelpers
  module ActionViewExtension
    def meta_tags(opts = {})
      opts = normalize_meta_hash(opts)
      default = {
        :"og:url"               => request.url,
        :"og:locale"            => I18n.locale.to_s,
        :"og:type"              => 'website',
        :"og:title"             => social_title,
        :"og:description"       => social_description,
        :"og:image"             => current_store.social_image_url,
        :"twitter:domain"       => current_store.url_with_protocol,
        :"twitter:title"        => social_title,
        :"twitter:description"  => social_description,
        :"twitter:account_id"   => current_store.twitter_id,
        :"twitter:site"         => current_store.twitter_name,
        :"fb:app_id"            => current_store.facebook_id
      }

      override_hash = controller.instance_variable_get("@_meta_tags_hash") || {}
      meta_hash = default.deep_merge(opts).deep_merge(override_hash)

      html = ""
      meta_hash.each { |k, value_or_array|
        values = value_or_array.is_a?(Array) ? value_or_array : [value_or_array]
        values.each { |v|
          if k.to_s =~ /[a-zA-Z_][-a-zA-Z0-9_.]\:/
            html << "<meta property=\"#{h(k)}\" content=\"#{h(v)}\" />\n"
          else
            html << "<meta name=\"#{h(k)}\" content=\"#{h(v)}\" />\n"
          end
        }
      }
      html.html_safe
    end
  end

  module ActionControllerExtension
    extend ::ActiveSupport::Concern
    included do
      helper_method :set_meta, :meta_type, :normalize_meta_hash
    end

    def _meta_tags_hash
      @_meta_tags_hash ||= {}
    end

    def set_meta(options)
      _meta_tags_hash.deep_merge!(normalize_meta_hash(options))
    end

    def meta_type(val = nil)
      if val
        @_meta_type = val
        set_meta(og: { type: val })
      end
      @_meta_type
    end

    protected

    def normalize_meta_hash(hash)
      normalized = {}
      normalize_meta_hash_walker(hash, normalized)
      normalized
    end

    private

    def normalize_meta_hash_walker(hash, normalized, current = nil)
      hash.each do |k, v|
        this_path = current ? current.dup : []
        this_path << k.to_s

        if v.is_a?(Hash)
          normalize_meta_hash_walker(v, normalized, this_path)
        elsif v
          key = this_path.join ":"
          normalized[:"#{key}"] = v
        end
      end
    end
  end
end
ActionController::Base.send :include, MetaTagsHelpers::ActionControllerExtension
ActionView::Base.send :include, MetaTagsHelpers::ActionViewExtension
