<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia DAM Asset Importer — configuration, cron import & queue worker

## Install / enable

- `composer require drupal/acquiadam_asset_import` then `drush en acquiadam_asset_import`.
- Requires **`media_acquiadam` >= 2.0** (Widen-backed Acquia DAM). Configure the DAM connection/credentials in
  `media_acquiadam` first — this module reuses that client and stores no credentials of its own.
- You must already have a **media type whose source is `acquiadam_asset`** (created via `media_acquiadam`) with a
  **`field_acquiadam_asset_id`** field. `DamImport::damBundles()` lists only media types with
  `source = acquiadam_asset`; if none exist the bundle select is empty and imports create nothing usable.

## Settings form

- Route **`acquiadam_asset_import.dam_import`** → path **`/admin/config/media/damimport`**, gated by
  `_permission: 'administer site configuration'`. Form `src/Form/DamImport.php` (`ConfigFormBase`, form id
  `dam_categories`). Menu link `acquiadam_asset_import.dam_import` under *Configuration → Media*.
- Writes the single config object **`acquiadam_asset_import.config`** (no `config/install` default and **no
  `config/schema`** ships — the object is untyped):
  - **`categories`** (textarea) — DAM category names, **one per line**. Split with `explode("\r\n", …)` in the
    importer, so entries must be CRLF-separated (Windows/textarea newlines).
  - **`bundle`** (select) — target media type machine name.
  - **`enable`** (checkbox) — master on/off switch for the cron import.

## Import mechanism (`DamImporter::import()`, `src/DamImporter.php`)

Called from `acquiadam_asset_import_cron()` (`hook_cron`) on every cron run:

1. Gets queue **`dam_worker`**; if it already has items (`numberOfItems() > 0`) it returns immediately (no new
   enqueue until the backlog drains).
2. Reads `categories` and `enable` from config; if `categories` is empty or `enable` is FALSE, returns.
3. Loads all already-imported asset IDs from **`media__field_acquiadam_asset_id`** (`field_acquiadam_asset_id_value`).
4. For each category name: calls the DAM client **`media_acquiadam.acquiadam`** (`Acquiadam`) —
   `getAssetsByCategory($name, ['limit' => 1])` for `total_count`, then loops fetching pages of
   `['limit' => 100, 'offset' => $i]`.
5. For each returned asset **not** already in Drupal, enqueues an item `['asset_id' => $asset->id, 'name' => $asset->name]`.
6. Returns the queue length.

Note: the paging loop uses `for ($i = 0; $i < $data['total_count']; $i + 100)` with the actual `$i = $i + 100`
increment inside the body — functional but fragile; a category whose `getAssetsByCategory` throws will surface as
an uncaught error on cron.

## Queue worker (`DamWorker`, `src/Plugin/QueueWorker/DamWorker.php`)

- `@QueueWorker(id = "dam_worker", cron = {"time" = 120})` — processes up to 120s of items per cron.
- `processItem($item)` reads `bundle` from `acquiadam_asset_import.config` and creates:
  `Media::create(['bundle' => $bundle, 'uid' => 1, 'name' => $item['name'], 'field_acquiadam_asset_id' => ['value' => $item['asset_id']]])->save()`.
- Imported media is **owned by user 1**. The media source (`acquiadam_asset`, from `media_acquiadam`) resolves the
  actual asset/file from the stored asset ID — this module does not download files itself.

## Operating

1. Configure DAM auth in `media_acquiadam`; create/confirm an `acquiadam_asset` media type + `field_acquiadam_asset_id`.
2. At `/admin/config/media/damimport`, list categories (one per line), pick the bundle, check **Enable DAM import**.
3. Run cron (`drush cron`) — first run enqueues new asset IDs; subsequent runs drain the `dam_worker` queue into
   media entities. Dedupe is automatic, so re-runs only add newly-added DAM assets.
4. To pause, uncheck **Enable DAM import** (already-queued items still process).

## Update hook

- `hook_update_8001()` (`.install`) renames the legacy `folders` config key to `categories` for 8.x-1.x → 2.0.x
  upgrades (untested per maintainers).
