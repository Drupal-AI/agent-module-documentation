<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Purge — Purger service, form & Drush commands

## The `Purger` service (`custom_purge.purger` = `Drupal\custom_purge\Purger`)

Constructed with config.factory, module_handler, logger.factory, `plugin.manager.custom_purge`,
queue, datetime.time. Optional `setMessenger()` makes it print status/warnings/errors to the UI
(used by the form). Two public methods, both returning
`['processed' => [], 'errors' => [], 'skipped' => [], 'queued' => []]` grouped by `item_key`.

### `purgeUrls(array $urls, array $caches = [], bool $enqueue = FALSE, int $add_delay = 0)`
- Reads `profiles.<profile>.domains`; groups URLs by domain (longest-domain-first; protocol-aware;
  fallback to `parse_url` host, then default domain). Errors + returns if no domains / no default.
- For each domain, gets assigned plugins (optionally filtered by `$caches`); skips a plugin whose
  `allow_url_purge` is false (into `skipped`). If `$enqueue`, and the plugin's
  `delay_complete_purge + $add_delay > 0`, creates a `custom_purge_urls` queue item
  (`urls`, `target_time`, `cache_name`, `item_key`) instead of purging now.
- Otherwise calls `$plugin->purgeUrls($domain_urls)`, logging INFO on processed and ALERT on
  errors, and invokes `hook_manual_custom_purge($urls)` at the end.
- `$caches` filter shape: `['type' => 'varnish'|['varnish',...]]` and/or
  `['name' => 'my_varnish'|[...]]`.

### `enqueuePurgeEverything(array $domains = [], array $caches = [], int $add_delay = 0, bool $ignore_existing_items = FALSE, bool $reset_queue = FALSE, bool $ignore_delay_run_immediately = FALSE)`
- Validates `$domains` against configured domains (defaults to all configured). Resolves the
  unique set of plugins across those domains.
- Uses queue `custom_purge_everything`; optionally `deleteQueue()` first (`reset_queue`) and reads
  existing items to de-dupe by `item_key` (unless `ignore_existing_items`).
- Per plugin: skips if `allow_purge_everything` false (`skipped`); if `ignore_delay_run_immediately`
  or effective delay 0, runs `purgeEverything()` now (INFO/ALERT log); else creates a queue item
  with `target_time = now + delay` (`queued`).

## Queue workers

- `custom_purge_urls` (`Plugin/QueueWorker/CustomPurgeUrls`) — on each item calls
  `purger->purgeUrls($data['urls'], ['name' => [$data['cache_name']]])` once `target_time` is
  reached.
- `custom_purge_everything` (`CustomPurgeEverything`) — calls
  `purger->enqueuePurgeEverything($data['domains'], ['name' => [$data['cache_name']]], 0, FALSE,
  FALSE, TRUE)` (immediate run for that one instance) once `target_time` is reached.
- Base `CustomPurgeWorkerBase::targetTimeReached()` — if the target time is still in the future it
  `sleep(1)` and re-creates the item in `custom_purge_everything` (returning FALSE), so items
  effectively poll until due. Both workers have `cron` time 10s; drain manually with
  `drush queue:run custom_purge_urls` / `drush queue:run custom_purge_everything`.

## The URL-purge form (`Form\UrlPurgeForm`)

Route `custom_purge.url_purger` → `/admin/config/custom_purge/url_purger`, permission
`use custom_purge url purger`, admin route. A standard `FormBase` (Drupal form-token / CSRF
protection applies). Textarea of URLs (one per line).
- **Flood control** (`custom_purge.flood` = core `DatabaseBackend`): `validateForm()` checks
  `flood->isAllowed('custom_purge_url_purger', flood_limit, flood_interval*3600, ...)`; the form is
  disabled once the count reaches `flood_limit`. `getFloodCount()` counts rows in the `flood`
  table for the event. `submitForm()` registers one flood event per URL. `hook_cron()` runs
  `custom_purge.flood->garbageCollection()`.
- **Validation**: splits lines, `array_filter`, rejects if count > `max_url_per_request`, and
  validates each with `FILTER_VALIDATE_URL`.
- **Submit**: sets the messenger on the purger and calls `purgeUrls($urls)` (immediate, all
  assigned caches).

## Drush commands (`Commands\CustomPurgeCommands`, `drush.services.yml`)

### `custom-purge:url <url>`
Purge one or more URLs (comma-separated). Options: `--cache-type` (e.g. `varnish,cloudflare`),
`--cache-name`, `--enqueue` (use configured delays via `custom_purge_urls` queue),
`--add-delay=<seconds>`. Prints processed / skipped / errored / queued per `item_key`.
Example: `drush custom-purge:url https://www.example.com/my-content --enqueue`.

### `custom-purge:enqueue-purge-everything`
Purge whole caches. Options: `--domain` (comma-separated, must be configured), `--cache-type`,
`--cache-name`, `--add-delay`, `--ignore-existing-items`, `--reset-queue`,
`--ignore-delay-run-immediately`. Immediate vs. queued is decided by each instance's
`delay_complete_purge` (+ `--add-delay`).
Example: `drush custom-purge:enqueue-purge-everything --domain=example.com --add-delay=3600 --ignore-existing-items`.

## Hook

`hook_manual_custom_purge(array $urls)` (`custom_purge.api.php`) — invoked by `purgeUrls()` after a
manual purge so other modules can react (`$urls` are the URLs that were (attempted to be) purged).
