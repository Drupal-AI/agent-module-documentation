# Commerce Ajax Add to Cart — agent index

Makes Drupal Commerce's Add to cart form submit over AJAX (refreshing the `.cart--cart-block`
in place) and shows a configurable confirmation: a non-modal message, a modal dialog, or a
Colorbox pop-up. Requires `commerce_cart`. One permission `access ajax atc administration pages`.
No Drush, no configure route in info.yml (settings live under *Commerce → Configuration → Ajax*).

- **Turn it on for a display + all global pop-up settings (config keys, settings form, permission)** →
  [configure/settings.md](configure/settings.md)
- **How it works: the AJAX callback, the cart-subscriber swap, pop-up types, view mode & twig** →
  [api/mechanics.md](api/mechanics.md)

Key facts:
- Enable per display: the `enable_ajax` **third-party setting** (`commerce_ajax_atc`) on the
  `commerce_add_to_cart` formatter, stored on the `variations` component of the product's
  `entity_view_display` (e.g. `core.entity_view_display.commerce_product.default.default`).
- Global config object `commerce_ajax_atc.settings`; central key `pop_up_type` ∈
  {`non_modal`, `modal_dialog`, `colorbox`}. Settings form route
  `commerce_ajax_atc.ajax_settings_form` → `/admin/commerce/config/ajax-settings`.
- Swaps `commerce_cart.cart_subscriber` for `AjaxCartEventSubscriber` to suppress Commerce's
  default add-to-cart message.
