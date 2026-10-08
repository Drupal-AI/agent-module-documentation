# Commerce Cart Redirection — agent index

Redirects a Commerce shopper to checkout / cart / a custom URL right after they add a
matching product **variation** to the cart. No plugins, no Drush. One config object
`commerce_cart_redirection.settings`; one settings form; one event subscriber. Requires
`commerce` + `commerce_product`. Nothing redirects until configured.

- **Settings form, all config keys, permission, how to set it via drush** →
  [configure/settings.md](configure/settings.md)
- **How the redirect actually happens (events, bundle matching, clear-cart, button text)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config: `commerce_cart_redirection.settings` (no `config/install` defaults; keys read with `??` fallbacks).
- Configure route: `commerce_cart_redirection.commerce_cart_redirection_config_form` at
  `/admin/commerce/config/commerce_cart_redirection`; permission `configure commerce_cart_redirection`.
- Matching is on **`commerce_product_variation` bundles** (the `product_bundles` checkboxes, form-keyed
  by variation bundle; note the historical `product_bundles` name — see the code comment).
