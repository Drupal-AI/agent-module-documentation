# Basic Cart — agent index

Simple session (or DB) shopping cart + checkout for small sites. Enable content types as buyable → nodes
get an `add_to_cart` field → visitors add to cart → checkout creates a `basic_cart_order` node → admin/
customer emails sent. Settings at `/admin/config/basic-cart/settings` (`basic_cart admin_cart`). Requires
`telephone` and `entity_reference_quantity`.

- **Cart + checkout settings, the order content type, email templates/tokens** →
  [configure/settings.md](configure/settings.md)
- **Routes, the cart storage/`Utility` API, blocks, the add-to-cart field/formatters, the VBO action** →
  [api/cart.md](api/cart.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Drush command** → [drush/drush.md](drush/drush.md)

Key facts:
- Config: `basic_cart.settings` (display/labels/currency/redirect) and `basic_cart.checkout` (emails +
  thank-you). `config_translation` supported.
- Routes (`basic_cart use_cart`): `/cart`, `/checkout`, `/cart/add/{nid}` (AJAX JSON), `/cart/remove/{nid}`,
  `/cart/add/direct/{nid}`, `/thankyou`. Admin: `/admin/config/basic-cart/settings|checkout`. Direct order:
  `node/add/basic_cart_order` (`basic_cart create_direct_orders`).
- Order content type `basic_cart_order` + its fields + orders View ship in `config/install`.
- Notifications: `basic_cart_order_send_notifications()` via `hook_mail` (`admin_mail`, `user_mail`),
  token-replacing the configured bodies.
