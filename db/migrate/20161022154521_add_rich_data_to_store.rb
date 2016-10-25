class AddRichDataToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_stores, :social_image_url, :string
    add_column :spree_stores, :show_entity_markup, :boolean, default: true

    add_column :spree_stores, :facebook_id, :string
    add_column :spree_stores, :twitter_id, :string

    add_column :spree_stores, :facebook_url, :string
    add_column :spree_stores, :linkedin_url, :string
    add_column :spree_stores, :pinterest_url, :string
    add_column :spree_stores, :twitter_url, :string
  end
end
