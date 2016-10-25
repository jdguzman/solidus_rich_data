Spree::ProductsController.class_eval do
  before_action :set_rich_data, :show

  def set_rich_data
    if @product
      taxonomy_brand = Spree::Taxonomy.find_by_name('Brand')
      brand = @product.taxons.where(taxonomy_id: taxonomy_brand)
      brand_name = brand.present? ? brand.first.name : nil
      set_meta og: {
        url: current_store.url_with_protocol(product_path(@product)),
        type: 'product',
        price: {
          amount: @product.price,
          currency: current_pricing_options.currency,
          # TODO: standard_amount: 'if on sale?'
        },
        availability: (@product.master.can_supply? ? 'instock' : 'backorder'),
        brand: brand_name,
        image: @product.images.map { |i| i.attachment.url(:product) }
      },
      twitter: {
        card: 'product',
        label1: 'Price',
        data1: @product.price,
        label2: 'Brand',
        data2: brand_name,
        image: @product.images.map { |i| i.attachment.url(:product) }
      }
    end
  end

  def social_title
    if @product
      Spree.t('rich_data.social_title.product', product: @product.name, site: current_store.name)
    else
      super
    end
  end

  def social_description
    if @product
      Spree.t('rich_data.social_description.product', product: @product.name, site: current_store.name)
    else
      super
    end
  end
end
