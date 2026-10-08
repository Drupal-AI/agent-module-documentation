<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VBO Add To Wishlist (vbo_add_to_wishlist) — agent index

**Views Bulk Operations action to add multiple selected Commerce products to the current user's default wishlist.**

- **Version:** 3.0.x (3.0.1)
- **Core:** ^9 || ^10 || ^11
- **Requires:** views_bulk_operations, commerce_wishlist (+ Drupal Commerce)
- **Action plugin:** `vbo_add_to_wishlist` (ViewsBulkOperationsActionBase), `confirm = FALSE`, type = "" (all entity types)
- **Behaviour:** loads each product's first variation, gets/creates the current user's `default` wishlist, adds a `commerce_product_variation` wishlist item if not already present (duplicate check via bound DB query)
- **Setup:** add *Global: Views bulk operations* field to a product view → enable this action
- **No routes/permissions/config of its own**

**Security:** writes only to the acting user's own wishlist (owner = current user id); duplicate-check query uses bound placeholders (no SQLi). `access()` returns TRUE for non-node entities, but the action cannot affect other users' wishlists. Gated in practice by the host view's access + VBO configuration.
