<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynCommerce (syncommerce) — agent index

**JS admin app + JSON endpoints for browsing and editing Drupal Commerce products and variations.**

- **Version:** 1.x (dev-1.x checkout)
- **Core:** ^9 || ^10 || ^11 · **Depends:** commerce
- **Controller:** `SyncommerceController` — `build` (UI page), `list`, `updateProduct`, `updateVariation`.
- **Routes:** `/syncommerce/products` (GET UI), `/syncommerce/products_list` (POST), `/syncommerce/updateProduct` (POST), `/syncommerce/updateVariation` (POST).
- **Permission defined:** `administer syncommerce configuration`.
- **Route access:** every route uses `_permission: 'access content'`.

See [api/syncommerce.md](api/syncommerce.md)
