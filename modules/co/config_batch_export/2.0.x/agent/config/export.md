<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch configuration export — mechanism, routes, operation

## Install & enable

```bash
composer require drupal/config_batch_export
drush en config_batch_export -y
```

Dependencies are core only: `config`, `file`, `datetime`. **Prerequisite:** the private
filesystem must be configured, because the finished archive is written to `private://` — set in
`settings.php`:

```php
$settings['file_private_path'] = '../private';
```

No config form, no config objects, no config schema, no permissions of its own, no Drush
commands. `.info.yml` `configure: config.sync` just links the module row to core's config-sync
page.

## Where the button comes from

`config_batch_export_form_config_export_form_alter()` (`config_batch_export.module`) alters core's
**`config_export_form`** (the *Configuration → Development → Configuration synchronization → Export
→ Export all* form at `/admin/config/development/configuration/full/export`). It:

1. calls `ConfigBatchExportController::unlock(TRUE)` to clear any stale lock when the form loads,
2. adds a `#type => button` **"Export in batch"** (`#button_id = export_batch_btn`) with
   `#executes_submit_callback = TRUE` and submit handler `_config_batch_export_export_button_callback`,
3. disables the button when `ConfigBatchExportController::isLocked()` is TRUE.

The submit handler redirects to route `config_batch_export.export_download` (or, if locked, shows
"The operation is locked. Config file is in progress of generation").

## Routes & permissions (`config_batch_export.routing.yml`)

| Route | Path | Controller | Requirement |
|---|---|---|---|
| `config_batch_export.export_download` | `/admin/config/development/configuration/full/export-download-batch` | `ConfigBatchExportController::downloadExport` | `_permission: 'export configuration'` |
| `config_batch_export.export_download_file` | `…/export-download-batch-file/{file}` (`{file}` = `entity:file`, `\d+`) | `ConfigBatchExportController::downloadExportFile` | `_permission: 'export configuration'` |

Both routes require the **core `export configuration`** permission (a "restrict access" /
security-sensitive permission). The module defines no permission of its own.

## Controller (`src/Controller/ConfigBatchExportController.php`)

`ConfigBatchExportController extends \Drupal\config\Controller\ConfigController`, so it inherits
`$this->configManager` and `$this->targetStorage` (the active config storage). Constants:
`BATCH_SIZE = 10`, `LOCK_ID = 'config_batch_export_download'`.

### `downloadExport()` — trigger the batch

1. `lock()` via `lock.persistent` (`acquire(LOCK_ID, 600)`); on failure redirects back with
   *"Can't lock the operation"*.
2. Creates a temp file: `file_system->tempnam('temporary://', hash('adler32', 'config_batch_export'))`,
   deletes any previous `private://configs.tar` / `private://configs.tar.gz` file entities, then
   creates a **temporary** `File` entity owned by the current user pointing at the temp path.
3. Builds `$batch_data['configs']` from `configManager->getConfigFactory()->listAll()` **plus**
   every name in every non-default collection (`targetStorage->getAllCollectionNames()` →
   `createCollection($collection)->listAll()`), each stored as `['name'=>…, 'collection'=>…]`.
4. `batch_set()` with one operation `callbackBatchJob([$batch_data])` and finished callback
   `callbackBatchFinished`, then `batch_process($redirect_url)` (redirect back to
   `config.export_full`).

### `callbackBatchJob($batch_data, &$context)` (static) — build the tar

- First call seeds `$context['sandbox']` (filename = temp file URI, offset 0, total = config
  count, batch_size 10) and records `results['file_id']`.
- Each pass takes `array_slice($configs, offset, 10)`, opens `new ArchiveTar($filename)`
  (**uncompressed** tar), and for each item:
  - plain string name → `addString("$name.yml", Yaml::encode($config_factory->get($name)->getRawData()))`;
  - array (collection item) → reads via `config_batch_export.config_storage`
    (`createCollection($collection)->read($name)`) and adds it under
    `str_replace('.', '/', $collection) . "/$name.yml"`.
- `unset($archiver)` flushes the tar (ArchiveTar writes on destruct); `offset += 10`;
  `$context['finished']` advances. **Note:** `finished` is computed as `offset / total` *before*
  the offset increment when items remain, and set to `1` only when a slice comes back empty —
  i.e. the loop runs one extra empty pass to terminate.

### `callbackBatchFinished($status, $results)` (static) — gzip & finalize

- Loads the file entity by `results['file_id']`, renames it to `configs.tar` at `private://`.
- `prepareDirectory('private://', CREATE_DIRECTORY | MODIFY_PERMISSIONS)`.
- If `extension_loaded('zlib')`: streams the tar through `gzopen()/gzwrite()` in 4096-byte reads to
  `private://configs.tar.gz` (name gets `.gz`). On `gzopen`/`fopen` failure it logs via
  `watchdog_exception`, `unlock()`s, and returns. Otherwise (no zlib) it `move()`s the tar to
  `private://` and renames it.
- Deletes the temp tar, `save()`s the file entity, then messages a download link to route
  `config_batch_export.export_download_file` and `unlock()`s.

### `downloadExportFile(FileInterface $file)` — stream the archive

- Throws `AccessDeniedHttpException` if `isLocked()` (an export is mid-flight).
- Sets the file's changed time to `1` (marks it **stale** so core `file_cron` garbage-collects it),
  then streams it through core `FileDownloadController::download()` for the file's stream scheme.

### Locking

`lock()/unlock()/isLocked()` use the **persistent** lock backend (`lock.persistent`) with
`LOCK_ID` and a 600-second TTL, so only one export runs at a time and the button is disabled while
locked.

## Download authorization hook

Serving anything from `private://` runs every `hook_file_download()`.
`config_batch_export_file_download($uri)` returns a `Content-disposition: attachment` header
(filename `config-<host>-<Y-m-d-H-i>.tar[.gz]`) when the request's route `file` parameter matches a
file entity with that URI **and** the current user has the `export configuration` permission;
otherwise it returns `NULL` (no opinion). This is what makes the private archive downloadable via
the `export_download_file` route.

## The null-cache storage service

`config_batch_export.services.yml` defines `config_batch_export.config_storage` →
`Config\Storage` (a bare subclass of core `CachedStorage`) wired to `@config.storage.active` and a
**`NullBackendFactory`-backed** cache backend (`config_batch_export.cache_backend.null`). Using a
null cache means collection reads during the batch always hit active storage fresh rather than a
possibly-stale cache.

## Operate it

1. Go to `/admin/config/development/configuration/full/export`, **Export all** tab.
2. Click **Export in batch**; watch the batch progress bar ("Processed N out of Total").
3. On completion a status message shows a **download link** — click it to download
   `config-<host>-<date>.tar.gz`.
4. The archive lives at `private://configs.tar.gz`; it is marked stale on download and removed by
   cron file garbage collection. A subsequent export deletes any prior archive first.

## Gotchas

- Requires the **private filesystem** configured; without `file_private_path` the finalize step
  cannot write `private://` and the export fails.
- Produces a plain `.tar` (not `.gz`) when the PHP **zlib** extension is not loaded.
- The archive path is **fixed** (`private://configs.tar.gz`) and not per-user — any holder of
  `export configuration` can trigger, overwrite, and download it.
- Several `@todo`s in the source note the reliance on `\Drupal::` static calls and the fixed
  temp/archive filenames.
