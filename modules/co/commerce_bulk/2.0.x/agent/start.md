<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Bulk (commerce_bulk) — agent index

**Mass-creates and maintains Drupal Commerce product variations, attribute values, and taxonomy terms via a service plus VBO-style Action plugins.**

- **Version:** 2.0.x
- **Core:** `^9.5 || ^10 || ^11`
- **Dependencies:** `commerce:commerce_order`, `drupal:action`, `drupal:taxonomy`
- **Submodule:** `commerce_generate` (dummy product generation via Devel Generate).

Key surfaces:
- Service `commerce_bulk.variations_creator` (`BulkVariationsCreator`) — Cartesian variation generation with unique SKUs + duplicate detection.
- Field widget `BulkSkuWidget` (SKU prefix/suffix, `uniqid()` toggle, max-per-run cap).
- Action plugins (config entities): variation duplicate/priceadjust/priceset/sku/status/title/top/delete, attribute-value top/name/delete, term duplicate/delete, and `commerce_bulk_order_zanonymize` (Anonymize Orders).
- Entity class override `BulkProductVariation`; UI via 3 bundled Views + `/product/{id}/variations` tab.

**Security:** No routes or permissions of its own; all actions ride existing Commerce/Drupal admin permissions and each Action enforces the relevant entity access (e.g. `OrderAnonymize::access()` checks `$order->access('update')`). `uniqid()`/`mt_rand()` are used only for SKUs and order-anonymization junk, not security tokens. No anonymous or mutating public endpoints.
