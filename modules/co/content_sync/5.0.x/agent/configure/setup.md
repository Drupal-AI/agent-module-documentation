<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup: sync directory, settings, routes, storage

## Install

```bash
composer require drupal/content_sync
drush en content_sync -y
```

## 1. Declare the content directory (required)

There is **no admin field for this** — it is a global in `settings.php`, mirroring core's
`$settings['config_sync_directory']`:

```php
// settings.php (or settings.local.php)
$content_directories['sync'] = '../content/sync';
```

`content_sync_get_content_directory('sync')` reads it, falling back to
`$content_directories['staging']` when `['sync']` is unset. If neither exists the module does
**not** throw — it pushes an error message to the UI and returns NULL, so a Drush export can look
like it ran while writing nothing. Verify first:

```bash
drush php:eval 'print content_sync_get_content_directory("sync");'
```

Make the directory writable by the web user; put it outside the docroot like the config dir.

## 2. Settings form — `content.settings`

`/admin/config/development/content/settings` (permission `synchronize content`), config object
`content_sync.AdminSettings`:

| Key | Default | Meaning |
|---|---|---|
| `site_uuid_override` | `"0"` | Bypass site-UUID validation, allowing import of content exported from a **different** site. |
| `help_menu_disabled` | `false` | Hides the "How can we help you?" help menu. |

```bash
drush cget content_sync.AdminSettings
drush cset content_sync.AdminSettings site_uuid_override 1 -y   # only for cross-site imports
```

Leave `site_uuid_override` off between environments of the *same* site (they share a site UUID);
turn it on only when deliberately importing foreign content — it disables the guard that stops
you overwriting one site's content with another's.

## 3. Routes / UI map

| Route | Path | Permission | What it does |
|---|---|---|---|
| `content.sync` | `/admin/config/development/content` | `synchronize content` | Change list (created/updated/deleted) between the sync dir and the site, with an Import all action |
| `content.diff` | `…/content/sync/diff/{source_name}/{target_name}` | `synchronize content` | Per-file diff |
| `content.diff_collection` | `…/content/sync/diff_collection/{collection}/{source_name}/{target_name}` | `synchronize content` | Diff inside a storage collection |
| `content.export_full` | `…/content/export/full` | `export content` | Batched export to an archive (`content.tar.gz`) or the sync directory |
| `content.export_download` | `…/content/export/download` | `export content` | Downloads `content.tar.gz` from the temp directory |
| `content.export_single` | `…/content/export/single` | `export content` | Shows one entity's YAML on screen |
| `content.export_multiple_confirm` | `…/content/export/confirm` | `export content` | Confirm form for the *Export content* node action |
| `content.import_full` | `…/content/import/full` | `import content` | Upload an archive and import it |
| `content.import_single` | `…/content/import/single` | `import content` | Paste one entity's YAML and import it |
| `content.overview` | `…/content/logs` | `logs content` | Content-sync log messages |
| `content.settings` | `…/content/settings` | `synchronize content` | The settings form above |
| `content.help.about` | `/admin/help/content_sync/about` | `access administration pages` | Help page |
| `content_sync.element.message.close` | `/content_sync/message/close/{storage}/{id}` | logged-in + CSRF | Dismisses a UI message |

`configure` in `content_sync.info.yml` points at `content.sync` (the sync screen), not at the
settings form.

## 4. Storage created on install

`content_sync.install` → `hook_schema()`:

- **`cs_db_snapshot`** — the "active" content storage (`content.storage.active`,
  a `DatabaseStorage` over this table, wrapped by `content.storage` = `CachedStorage` with the
  `cache.content` bin). It holds the last exported/imported state and is what the change list
  diffs against. `hook_entity_update()` keeps it in step for content entities.
- **`cs_logs`** — rows written by the `logger.cslog` channel (`Drupal\content_sync\Logger\ContentSyncLog`),
  rendered by `content.overview`.

The sync (file) storage is `content.storage.sync` → `content.storage.staging`, a `FileStorage`
built by `ContentFileStorageFactory::getSync()` over the directory from step 1.

## 5. Snapshot / reset recipes

```bash
# What does the module think the last-known state is?
drush sqlq "SELECT collection, COUNT(*) FROM cs_db_snapshot GROUP BY collection"

# Rebuild the snapshot from the live site by re-exporting everything.
drush content-sync:export sync --skiplist

# Inspect the module's own log.
drush sqlq "SELECT type, message, timestamp FROM cs_logs ORDER BY wid DESC LIMIT 20"
```
