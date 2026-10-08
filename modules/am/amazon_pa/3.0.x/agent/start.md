<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon PAAPI5 (amazon_pa) — agent index

Drupal wrapper + caching layer for the **Amazon Product Advertising API** (branch 3.x targets
Amazon's **Creators API**). Given ASINs it calls Amazon's official PHP SDK, normalises the response
into local tables, and renders product blocks/prices/images with affiliate links. Package `Amazon`.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version **3.0.1**.

The Amazon SDK is **not bundled** — it is `require_once`'d at the top of `amazon_pa.module` from
`/libraries/creatorsapi-php-sdk/vendor/autoload.php` (or the module's own `amazon_sdk/` dir) and must
be installed manually (INSTALL.txt). Without it the API classes are undefined.

## What it provides

- **No entities/services classes.** Core logic is **procedural** in `amazon_pa.module`: the SDK
  wrappers `amazon_pa_getItems()` / `amazon_pa_searchItems()`, and the lookup/cache pipeline
  `amazon_pa_item_lookup()` → `amazon_pa_item_lookup_from_db()` / `amazon_pa_item_lookup_from_web()`
  → `_amazon_pa_item_batch_lookup_from_web()` → `amazon_pa_api_request()`. See
  [api/lookup.md](api/lookup.md).
- **4 admin forms / routes** (all `_permission: 'administer amazon pa settings'`, `restrict access`):
  settings, storage/cron, test query, database cleanup. One config object `amazon_pa.settings`
  (+ schema). See [config/settings.md](config/settings.md).
- **1 permission**: `administer amazon pa settings` (`amazon_pa.permissions.yml`).
- **Hooks**: `hook_cron` (refresh), `hook_theme` (14 templates), `hook_node_view` / `hook_node_update`
  (optional data refresh), `hook_views_api`. Utility class `Drupal\amazon_pa\Utils\AmazonPaUtils`
  (locale cache). `Controller\AmazonPAController` is an empty stub.
- **4 DB tables** created by `amazon_pa_schema()` in `amazon_pa.install`: `amazon_item`,
  `amazon_item_participant`, `amazon_item_image`, `amazon_item_image_gallery`.
- **Library** `amazon_pa/amazon_pa` (CSS only).

## Submodules (own doc trees)

- **`amazon_pa_filter`** — `[amazon:ASIN:selector]` text-format filter (plugin `AmazonFilter`, id
  `amazon`). → [modules/amazon_pa_filter/3.0.x/agent/start.md](../../modules/amazon_pa_filter/3.0.x/agent/start.md)
- **`asin`** — ASIN field type (`asin`), widget (`asin_text`), 13 field formatters, and Views
  integration over the cached tables. → [modules/asin/3.0.x/agent/start.md](../../modules/asin/3.0.x/agent/start.md)

## Operate it

1. Install the Amazon SDK into `/libraries` (INSTALL.txt), enable `amazon_pa`.
2. At `/admin/config/services/amazon` enter credential id/secret/version and a per-locale associate ID.
3. Set the refresh schedule/cron limit at `/admin/config/services/amazon/storage`.
4. Verify with a single ASIN at `/admin/config/services/amazon/test`.
5. Enable `amazon_pa_filter` and/or `asin` to actually surface products on the site.
