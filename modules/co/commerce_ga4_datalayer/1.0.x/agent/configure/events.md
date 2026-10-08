<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce GA4 DataLayer — events & mapping

## Flow
Commerce event → `GA4EventSubscriber` builds payload via `GA4DataLayerBuilder`/`GA4DataLayerHelper` → queued in PHP session → `hook_page_attachments` flushes to `drupalSettings.ga4Events` → shipped JS pushes to `window.dataLayer`.

## Events
Cart add/remove, `commerce_order.place.post_transition` (purchase), `KernelEvents::REQUEST` (checkout-step detection for begin_checkout / add_shipping_info / add_payment_info), plus `hook_user_login`/`hook_user_insert` for login/sign_up.

## Settings (`/admin/commerce/config/ga4-datalayer`)
- Enable/disable each event.
- Map custom item params (item_brand, item_variant, item_category, ...) to product/variation **tokens**.
- `item_category` can walk up N taxonomy parent levels for a hierarchical category.
- Exclude selected roles from tracking.

## Extending
- `hook_commerce_ga4_datalayer_item_alter(&$item, $context)` to adjust item payloads.
- Public builder API (`GA4DataLayerBuilder`) to queue custom events (e.g. select_item, search) from other modules.
- Decorate `commerce_ga4_datalayer.helper` to override `buildItemData()`.

## Notes
Adjusted (post-promotion) prices are reported; coupon + promotion id/name captured per line item; login event carries a SHA-256 hash of the email.
