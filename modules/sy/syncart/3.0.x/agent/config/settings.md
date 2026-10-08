<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syncart settings & install

## Install / enable
`drush en syncart -y` (pulls in `commerce_cart`, `commerce_checkout`, `commerce_order`).
`hook_install()` (`syncart.install`) rewrites bundled config into the site: the default
`commerce_checkout.commerce_checkout_flow.default`, the `profile.customer` form/view displays,
`commerce_user_orders` / `commerce_order_item_table` views, order form/view displays, and the
product default/teaser displays (via `syncart.install` service `updateOrInstallAdditionalConfig`).
`config/install/**` also provisions user fields (`field_user_name`, `field_user_surname`,
`field_user_phone`), customer profile fields (`field_customer_name/surname/phone/email/comment`),
product `field_stock`, and the `product_cart` image style. Update hook `syncart_update_8201`
installs `commerce_checkout_link` if absent. Language-specific view config lives under
`config/settings/{en,es,kk,ru}/`.

## Settings form
Route `syncart.settings` → `/admin/config/syncart`, permission `administer site configuration`,
`Form\Settings` (a `ConfigFormBase`, form id `syncart`, editable config `syncart.settings`).
Keys written by `submitForm()`:

- `check_store` (bool) — enforce stock availability on add-to-cart.
- `no_variation_text` (string) — label for a product with no variations.
- `note` (bool) — enable per-order-item notes (drives `/cart/set-item-note` and cart JSON `note`).
- `donation` (bool) — donation mode: `/cart/add-item` reads a `donation` amount and reuses/creates a
  variation priced at that amount instead of trusting `vid` (see api doc).
- `registration` (bool) — calls `SynCartService::updateUserRegister()` on save.
- `registration_fields` (bool) — toggles registration form fields.
- `show_quantity` (bool) — show a quantity selector on the add-to-cart widget.
- `cart_time_limit` — persisted in `submitForm()` (no matching form element in `buildForm()`).

No `config/schema/` is shipped, so `syncart.settings` is schema-less.

## Admin utilities
- `AdminController::page` (`/admin/config/syncart/administer`, perm `administer commerce_order`)
  lists Commerce order types and their number patterns via `AdminService`.
- `AdminController::flushSequence` (`/admin/config/syncart/flush_sequence/{number_pattern_id}`)
  resets a number pattern's running sequence (`AdminService::resetNumberPatternSequence`). Note the
  UI/labels here are Russian.
- Menu/task links: `syncart.links.menu.yml`, `syncart.links.task.yml`.
