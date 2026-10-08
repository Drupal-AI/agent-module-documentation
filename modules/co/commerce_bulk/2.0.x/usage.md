<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Bulk speeds up building and maintaining large Drupal Commerce catalogs by mass-creating product variations, attribute values, and taxonomy terms.

---

The core is the `commerce_bulk.variations_creator` service (`BulkVariationsCreator`), which computes the full Cartesian product of a variation type's attribute options, subtracts combinations already in use, and generates every not-yet-used variation in one operation with auto-generated unique SKUs, a default price, and duplicate detection. Around that service the module ships a UI layer of VBO-style Action plugins exposed on a per-product `/product/{id}/variations` tab plus the product-attributes, taxonomy, and orders pages, added via `hook_entity_operation`. It overrides the `commerce_product_variation` entity class with `BulkProductVariation`, provides a `BulkSkuWidget` field widget controlling SKU prefix/suffix, `uniqid()` toggling, and a maximum-per-run cap, and exposes alter hooks (`hook_bulk_creator_sku_alter`, `hook_commerce_bulk_variation_alter`, etc.).

The module defines no routes or permissions of its own — everything runs through core Action config entities and three bundled Views, gated by the existing Commerce/Drupal admin permissions (manage variations, `administer commerce_product_attribute`, `administer taxonomy`, order update). Notable is the `OrderAnonymize` action for GDPR-style scrubbing: it overwrites selected order fields with randomized junk (optionally only orders older than N days) and can be driven from cron. SKUs use PHP `uniqid()` (not a security token). Typical setup: install, open a product's Variations tab, configure the SKU widget's auto-pattern on the variation type form display, then run Create / Duplicate / Set price / Change status actions. The bundled `commerce_generate` submodule integrates with Devel Generate to fabricate dummy products with variations.

---

- Generate every possible variation for a multi-attribute product in one click.
- Generate only a capped subset (max-per-run) to stay within performance limits.
- Auto-assign unique SKUs to newly created variations.
- Set a custom SKU prefix/suffix pattern per variation type.
- Hide the SKU field on the variation form while still auto-generating valid SKUs.
- Duplicate a single variation or all variations of a product at once.
- Bulk delete selected variations.
- Bulk set a fixed price across selected variations.
- Bulk adjust (increase/decrease) prices across selected variations.
- Bulk change the published status of variations.
- Bulk change or regenerate variation titles.
- Bulk regenerate/change SKUs on existing variations.
- Reorder variations by moving selected ones to the top.
- See a "created / not used / maximum" count on the product's Variations tab.
- Get warned about duplicated attribute combinations on a product.
- Bulk-create attribute values and rename them in bulk.
- Bulk delete attribute values, or move them to the top to reorder.
- Bulk duplicate, rename, reorder, or delete taxonomy terms.
- Anonymize selected orders' PII (mail, IP, billing/shipping profile) for GDPR.
- Anonymize only orders older than N days on a scheduled cron job.
- Programmatically create products + variations via the `BulkVariationsCreator` service.
- Generate dummy commerce products with variations for testing (Commerce Generate + Devel Generate).
- Alter generated SKUs, attribute values, or terms via the provided alter hooks.
