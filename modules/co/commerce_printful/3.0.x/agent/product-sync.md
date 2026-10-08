<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Product & variant sync

Pulls Printful **sync products** into Commerce. Entry points: the synchronization form
(`/admin/commerce/config/printful/synchronization`, route `commerce_printful.synchronization`,
perm `administer commerce printful`) and Drush `printful:sync-products` (alias `psp`). Both build a
Batch via `PrintfulSyncBatch::getBatch()`.

## Flow

`src/Form/PrintfulSynchronizationForm.php` collects `printful_store_id`, `update` (update existing
vs. new-only), and an optional single `printful_product_id` (entity autocomplete, shown only when
"update" is checked). → `batch_set(PrintfulSyncBatch::getBatch([...]))`.

`src/PrintfulSyncBatch::doSync()` (one product per batch step):
1. `commerce_printful.product_integrator` → `setPrintfulStore($store)` (sets api key + commerce
   store from the `printful_store` entity).
2. `getSyncProducts($offset, 1, $product_id)` → `Printful::syncProducts(...)`
   (`sync/products` list, or `sync/products/@<printful_id>` for one product).
3. `syncProduct($data)` — load-or-create a `commerce_product` by `printful_reference == external_id`;
   title = Printful `name`; assigned to the store's commerce store. Existing products are updated
   only when `update` is set.
4. `syncProductVariants($product, ...)` — fetch full product (`Printful::products($printful_product_id)`),
   then per Printful `sync_variant`: `syncProductVariant()` load-or-create a
   `commerce_product_variation` by `printful_reference == external_id`, set sku
   (`<product_id>-<variation_id>`), title, price (`retail_price` + `currency`), mark
   `commerce_stock_always_in_stock` if present. Orphaned variations not returned by Printful are
   deleted.

## Attribute & image mapping

`ProductIntegrator::syncProductVariant()` iterates `printful_store.attributeMapping`:
- `color` / `size` → `syncAttribute()`: load-or-create a `commerce_product_attribute_value`
  (bundle derived from the mapped field name) and set it on the variation.
- `image` → `syncImage()`: finds the variant's `preview` file, downloads it
  (`file_get_contents($file_data['preview_url'])` → `fileRepository->writeData()`), and stores it
  into either an `image` field or an `entity_reference`→`media` field (creates/updates a Media
  entity). Destination dir comes from the field's `file_directory` (token-replaced) + `uri_scheme`.

The image URL is supplied by Printful's authenticated API and the sync is admin-triggered.

## Form UX side effects

`commerce_printful.module` disables synced fields on the Commerce product/variation edit forms
(title, price, and mapped attribute fields, weight) with a "edit within the Printful UI" notice,
for any entity that has a `printful_reference->printful_id`.

## Drush

- `drush printful:test <store>` (`pt`) — prints Printful store info + a product table (connection check).
- `drush printful:sync-products <store> <update>` (`psp`) — runs the sync batch; interactive prompts
  pick the store and whether to update existing products.
