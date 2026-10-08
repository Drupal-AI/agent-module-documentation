<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — hash generation service, cron, Drush, request subscriber

## Service `sri_ui.hashgeneration`

`Drupal\sri_ui\Services\HashGeneration` (constructor args `@config.factory`, `@logger.factory`,
`@cache_tags.invalidator`). It holds an **editable** `sri_ui.settings` config object.

Public entry point:

```php
\Drupal::service('sri_ui.hashgeneration')->hashKeyGeneration(string $check_value = '');
```

`$check_value` selects the mode (`HashGeneration.php:70`):

- `'check_all'` — process **every** entry in `assets` unconditionally. Used by cron and Drush.
- `'check_one_by_one'` — process only entries with `is_check_update == TRUE`, and only once the
  throttle window has elapsed: `last_refresh_timout + key_refresh_timout <= time()`. Used by the
  request subscriber. On a change it also calls `clearLibraryCache()`.
- `''` (default) — same loop as `check_all` (used by the unit test).

Per entry, `checkSriHashKeys()` (`HashGeneration.php:143`) rebuilds the URL (appending
`?`/`&<query_string>` when set), calls the private `keyGenSriHash()`, and if the freshly computed value
differs from the stored `integrity` it writes the new `integrity` and marks the batch dirty. Only when
something changed does it `set('assets', …)`, refresh `last_refresh_timout`, and `save()`.

`keyGenSriHash()` (`HashGeneration.php:114`) computes the hash from the **file body**:

```php
$response   = file_get_contents($assets_link);   // downloads the configured URL
$hash       = hash('sha256', $response, TRUE);    // raw binary
$hash_base64 = base64_encode($hash);
return "sha256-$hash_base64";                      // e.g. sha256-47DEQp...
```

Each computed value is logged to the `sri_ui` logger channel (`notice`), recording the URL and the
new `sha256-…` value. The URLs processed are exactly the admin-entered `asset` values from
`sri_ui.settings`; nothing request-supplied is fetched.

## Trigger paths

- **Cron** — `hook_cron()` (`sri_ui.module:157`) calls `hashKeyGeneration('check_all')` on every cron
  run; all configured URLs are refetched and hashes updated if changed.
- **Drush** — `sri-ui:update-assets-hash256` (alias `update-assets-hash256`),
  `Drupal\sri_ui\Commands\SriUiDrushCommands::updateAssetsHash` → `hashKeyGeneration('check_all')`.
  Registered by `drush.services.yml` (`sri_ui.sri_ui_drush_commands`, tag `drush.command`). Run:
  `ddev drush update-assets-hash256`.
- **Request subscriber** — `sri_ui.subscriber` (`SriEventSubscriberCron`) listens on
  `KernelEvents::REQUEST` (`onPageLoad`, priority 0) and calls `hashKeyGeneration('check_one_by_one')`
  on **every** page request. In practice it only refetches when at least one asset has
  `is_check_update == TRUE` and the `key_refresh_timout` window has passed; otherwise the loop finds
  nothing to do.

## Notes for agents

- **Cache-tag mismatch (functional bug):** `hook_page_attachments_alter` attaches cache tag
  `sri_ui:library_attachments_cache_tag`, but `HashGeneration::clearLibraryCache()` invalidates the
  un-prefixed `library_attachments_cache_tag`. The two do not match, so an auto hash change may not be
  reflected on cached pages until a general cache rebuild (`ddev drush cr`). The settings form's own
  markup already tells editors to clear caches after saving.
- Auto-refresh only recomputes a hash from whatever the URL currently returns; for high-value assets
  prefer pasting a vendor-published hash and leaving `is_check_update` off, so the pinned hash is a
  reviewed value rather than a moving target.
