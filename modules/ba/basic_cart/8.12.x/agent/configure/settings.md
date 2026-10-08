# Configuring Basic Cart

Two config objects, two forms. Both admin forms require `basic_cart admin_cart`.

## Cart settings — `basic_cart.settings`
Form `CartSettingsForm` at `/admin/config/basic-cart/settings`. Key fields
(`config/install/basic_cart.settings.yml`):
- `content_type` — the content types enabled for selling. Enabling a type triggers
  `Utility::createFields()` to add the `add_to_cart` field (and price field) + a `basic_cart_order`
  view mode display to that bundle.
- Display toggles + labels: `quantity_status`/`quantity_label`, `price_status`/`price_label`,
  `total_price_status`/`total_price_label`, `currency_status`/`currency` (default `INR`), `price_format`,
  `vat_state`/`vat_value`.
- Buttons/titles: `add_to_cart_button`, `cart_page_title`, `empty_cart`, `cart_block_title`,
  `view_cart_button`, `cart_update_button`, `cart_updated_message`, `added_to_cart_message`,
  `checkout_page_title`, `placeorder_button_name`, `cart_button_name`.
- `add_to_cart_redirect` — path to redirect to after add-to-cart (used by `/cart/add/direct/{nid}`).
- `use_cart_table` (false) — store carts in a DB table instead of the session.
- `cart_items_linked`, `cart_items_view_mode`, `cart_items_block_view_mode`, `order_status`.

## Checkout settings — `basic_cart.checkout`
Form `CheckOutSettingsForm` at `/admin/config/basic-cart/checkout`
(`config/install/basic_cart.checkout.yml`):
- `admin_emails` — newline-separated admin recipient list (empty = site email).
- `admin.subject` / `admin.body` — admin notification template.
- `send_emailto_user` (false) + `user.subject` / `user.body` — customer confirmation template.
- `thankyou.title` / `thankyou.text` / `thankyou.custom_page` — the post-order thank-you page.
- Email bodies support tokens including `[node:title]`, `[site:name]`, and `[basic_cart_order:*]`
  (e.g. `[basic_cart_order:products]` renders the ordered items, `[basic_cart_order:basic_cart_total_price]`,
  `[basic_cart_order:basic_cart_email]`). Sent from `basic_cart_order_send_notifications()` via
  `hook_mail` keys `admin_mail` / `user_mail`.

## The order content type
`basic_cart_order` node type ships in `config/install` with fields: `basic_cart_address`, `basic_cart_city`,
`basic_cart_zipcode`, `basic_cart_phone` (telephone), `basic_cart_email`, `basic_cart_message`,
`basic_cart_vat`, `basic_cart_total_price`, and `basic_cart_content` (an `entity_reference_quantity`
reference to the ordered products). An `basic_cart_orders` View lists orders.
