<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product Quantity limits the maximum quantity a customer may purchase of a product or product type.

---

Commerce Product Quantity lets a store administrator cap how many units of a given Commerce product — or of
every product of a given product type — a customer may buy. It is a maximum-only limit: there is no minimum
and no step, and it does not add a quantity widget to the storefront. Instead it enforces the cap
server-side by listening to Commerce cart events (add-to-cart and cart quantity update) and clamping the
line-item quantity down to the allowed number, showing an error message when the limit is reached.

Administrators configure limits in two small forms under **Commerce → Configuration → Product** — one for
per-product limits (`/admin/config/system/commerce_product_quantity`) and one for per-product-type limits
(`/admin/config/system/commerce_product_type_quantity`). When a product is covered by both a per-product
and a per-product-type limit, the per-product limit takes precedence. Quantities otherwise flow through
Commerce's normal order handling; the module adds no access-control role of its own.

---

- Cap the maximum quantity of a specific product per order.
- Cap the maximum quantity of a product type per order.
- Enforce the cap server-side on add-to-cart and on cart quantity updates.
- Clamp an over-limit quantity down to the allowed maximum.
- Let per-product limits override per-product-type limits.
- Configure per-product limits at /admin/config/system/commerce_product_quantity.
- Configure per-product-type limits at /admin/config/system/commerce_product_type_quantity.
- Rely on Commerce's cart and order handling.
- Add no access-control role.
- Show a message when a limit is reached.
- Limit purchase quantity for fairness during a sale.
- Limit purchase quantity for limited-stock products.
- Set a maximum-per-order ceiling.
