Deface::Override.new(virtual_path: 'spree/layouts/spree_application',
                     name: 'add_head_prefixs',
                     set_attributes: 'head',
                     attributes: {
                      prefix: 'og: //ogp.me/ns# fb: //ogp.me/ns/fb# website: //ogp.me/ns/website#'
                     },
                     disabled: false)

Deface::Override.new(virtual_path: 'spree/layouts/spree_application',
                     name: 'add_rich_data_meta_data',
                     insert_bottom: 'head[data-hook=\'inside_head\']',
                     text: '<%= meta_tags %>',
                     disabled: false)

Deface::Override.new(virtual_path: 'spree/layouts/spree_application',
                     name: 'add_entity_markup',
                     insert_bottom: 'body',
                     partial: 'spree/shared/entity_markup',
                     disabled: false)

Deface::Override.new(virtual_path: 'spree/admin/stores/_form',
                     name: 'add_rich_data_form_extension',
                     insert_before: "erb[loud]:contains('f.field_container :mail_from_address do')",
                     partial: 'spree/admin/general_settings/rich_data_fields',
                     disabled: false)
