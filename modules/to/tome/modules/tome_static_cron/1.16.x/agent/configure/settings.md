<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Static Cron — configuration & flow

## Config object: `tome_static_cron.settings`
| Key | Type | Meaning |
|---|---|---|
| `base_url` | string (validated URL, required in the form) | Base URL used for cron-context static generation. **If empty, cron does nothing.** |

- Settings form: `/admin/config/services/tome_static_cron/settings`
  (route `tome_static_cron.settings`, permission **`use tome static`**).
- Set from code: `\Drupal::configFactory()->getEditable('tome_static_cron.settings')->set('base_url','https://example.com')->save();`
  or `drush cset tome_static_cron.settings base_url https://example.com -y`.
- No `configure` route is declared in info.yml, and there is no Drush command.

## How it works (`tome_static_cron_cron()` + `TomeStaticQueueWorker`)
1. On each cron, read `base_url`; return early if empty.
2. Return early if the `tome_static_cron` queue still has items (one cycle at a time).
3. Set the request base URL (`TomeStaticUrlHelper::setBaseUrl`), reset the worker's
   invoke/old path state keys.
4. Prepare/clean the static directory via `tome_static.generator`, then enqueue
   `$static->exportPaths($static->getPaths())` — each item `{path, base_url}` — plus a final
   `{action: 'process_invoke_paths', base_url}` marker.
5. `TomeStaticQueueWorker` (queue id `tome_static_cron`) renders each queued path on subsequent
   cron runs, queueing any newly discovered related paths/assets.

Because rendering uses Tome Static's `cache.tome_static` bin, already-cached paths are skipped —
builds are incremental. Trigger cron with system cron or `drush cron`.
