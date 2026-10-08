<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron import (sections + listings)

All import logic lives in `etsy_shop.module`; there is no queue, batch, form or route. `etsy_shop_cron()` runs `_etsy_shop_cron_process_sections($api)` then `_etsy_shop_cron_process_listings($api)`, where `$api = \Drupal::service('etsy.api')`.

## Sections → taxonomy terms

`_etsy_shop_cron_process_sections(EtsyService $api)`:
- `$api->getShopSections()`; on falsey result logs an error.
- For each `$sections->results` row (when `count > 0`): loads an `etsy_section` term by `field_shop_section_id`. If it exists, updates `name`, `field_shop_section_rank`, `field_shop_user_id`; else creates a new term with those values plus `vid = etsy_section`.

## Listings → etsy_listing nodes

`_etsy_shop_cron_process_listings(EtsyService $api)`:
- `$api->getListingsByShop(100, 0, [INCLUDES_IMAGES, INCLUDE_VIDEOS])`; on falsey result logs an error.
- For each `$listings->results` listing: loads an `etsy_listing` node by `field_etsy_listing_id`.
  - Exists → if `field_etsy_updated_timestamp` differs from `listing->updated_timestamp`, re-populate via `_etsy_store_listing_node()`; tracked as updated.
  - Missing → create a new `etsy_listing` node, populate, tracked as new.
- **Deletion**: an entity query (`accessCheck(FALSE)`, type `etsy_listing`, `field_etsy_listing_id NOT IN` the new+updated ids) finds nodes whose listings no longer appear, and deletes them — so the node set mirrors the API. (`accessCheck(FALSE)` is correct here: cron runs unprivileged and must see all listing nodes.)
- Logs an info summary (`@new`, `@updated`, `@removed`).

## `_etsy_store_listing_node(\stdClass $listing, NodeInterface &$node, $doSave = true)`

Maps API fields onto the node's `field_etsy_*` fields. Notable points:
- `title` = `listing->title`.
- **`body`** = `['value' => listing->description, 'format' => 'plain_text']` — description is stored with the `plain_text` format (no raw HTML rendering).
- `field_etsy_image` = the list of `image->url_fullxfull` URLs (string field; rendered via Imagecache External in the template).
- `field_etsy_price` = `['amount' => price->amount, 'divisor' => price->divisor, 'currency_code' => price->currency_code]` (the etsy_price field).
- `field_etsy_materials` / `field_tags` = term ids via `_etsy_shop_process_terms($vocab, $names)`, which loads-or-creates terms by name.
- `field_etsy_shop_section` = the matching `etsy_section` term id (by `field_shop_section_id`).
- `field_etsy_when_made` normalised (`before_*` → "Before …", `NNNN_NNNN` → "NNNN - NNNN", `made_to_order` → "Made to order").
- New nodes get `setCreatedTime(listing->created_timestamp)`; `field_etsy_created_timestamp` / `field_etsy_updated_timestamp` always set.
- Publish state: `state === 'active'` → published, else unpublished. Owner set to uid 1.
- Saves unless `$doSave` is false.

`_etsy_shop_process_terms($vocabulary, $terms)`: for each name, load a term by `name` (any vocab) or create one in `$vocabulary`; returns term ids.

## Operating notes

- Import is entirely cron-driven — run cron to sync. Requires a working `etsy.settings:shop_id` and an authorized OAuth2 connection (see base module).
- Listing nodes are import-managed; the content type help warns not to edit them manually (imports overwrite local changes).
