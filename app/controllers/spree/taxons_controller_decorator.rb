Spree::TaxonsController.class_eval do
  def social_title
    if @taxon
      Spree.t('rich_data.social_title.taxon', taxon: @taxon.name, site: current_store.name)
    else
      super
    end
  end

  def social_description
    if @taxon
      Spree.t('rich_data.social_description.taxon', taxon: @taxon.name, site: current_store.name)
    else
      super
    end
  end
end
