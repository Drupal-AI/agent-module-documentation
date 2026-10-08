<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Availability — agent index

Adds a **Product Availability field** to Drupal Commerce **product variations** and
enforces purchasability from it. The field carries `orderable` (bool — the only value that
governs whether a variation can be bought), `availability_status`
(`in_stock`/`out_of_stock`/`preorder`/`backorder`, alterable), an "Available from" date,
and min/max delivery periods. Purchasability is enforced **server-side**: a Commerce
availability checker blocks add-to-cart and an order processor removes unavailable items
from an order — not just a UI hint. Version **1.0.23**, core `^10 || ^11`.

Depends on `commerce`, `commerce_product`, `commerce_order`, `commerce_cart`.
`configure: commerce_product_availability.settings`. Package Commerce. Defines no plugin
type; provides a field type + widgets + formatter + tokens + one permission + one submodule.

- **How purchasability is enforced (availability checker, order processor, add-to-cart
  button altering, status alter hook)** → [enforcement.md](enforcement.md)
- **Field type properties/schema, the two widgets, the formatter + Twig template, global
  settings form, tokens, schema.org computed property, install hooks** →
  [field-and-display.md](field-and-display.md)
- **Submodule: "Order request" webform button (`commerce_product_availability_webform_request`)**
  → [webform-request.md](webform-request.md)

Key facts:
- Field type id **`commerce_product_availability_product_availability`** (category
  `commerce`); widgets `..._default` and `..._simple`; formatter `..._default` (extends
  core `DateTimeDefaultFormatter`). Only the first availability field per variation is
  honored.
- Services (`.services.yml`): `commerce_product_availability.availability_checker`
  (tag `commerce_order.availability_checker`),
  `commerce_product_availability.order_processor` (tag `commerce_order.order_processor`),
  and the token-hooks service.
- Permission: **`administer commerce_product_availability global settings`** guards the
  settings form at `/admin/commerce/config/products/commerce-product-availability`
  (config object `commerce_product_availability.settings`).
- Hook: `hook_commerce_product_availability_availability_status_alter(&$options)`
  (`commerce_product_availability.api.php`) to add/remove availability statuses.
- Tokens under type `commerce_product_availability` expose the global delivery-period
  fallbacks + info.
