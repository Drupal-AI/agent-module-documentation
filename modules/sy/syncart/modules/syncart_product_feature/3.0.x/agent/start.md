<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syncart. Product features (syncart_product_feature) — agent index

Syncart submodule adding paragraph-based product features/upsells. Core `^11 || ^12`.
Package Synapse. Depends on `paragraphs`, `syncart`, `shs`.

## Provides
- **Config additional** (`config/additional/**`): `product_feature` paragraph type;
  `product_feature` `commerce_product` type and `commerce_order_item_type`; fields
  `field_product_features` (product), `field_product_feature_products/title/widget/none` (paragraph),
  `field_json` (order item); form/view displays; content-translation settings.
- **Services** (`syncart_product_feature.services.yml`):
  - `syncart_product_feature.cart` → `Service\CartService` (add feature items to the cart).
  - `syncart_product_feature.install` → `Service\InstallService` (config provisioning).
  - `syncart_product_feature.order_processor` → `OrderProcessor\OrderProcessor`, tagged
    `commerce_order.order_processor` (priority -300) — applies the `syncart_product_feature`
    adjustment.
- **Adjustment type** (`syncart_product_feature.commerce_adjustment_types.yml`): `syncart_product_feature`.
- **Hook**: `Hook\ViewsPreRender`.
- No routes, permissions, or Drush commands.

## Parent
See `../../../3.0.x/agent/start.md` for the Syncart module.
