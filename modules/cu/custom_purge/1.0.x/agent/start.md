<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Purge (custom_purge) — agent index

Lightweight, **plugin-based cache purging**. Purges individual URLs or whole caches from
Drupal's internal page cache, **Varnish** and **Cloudflare**, with optional **queue-delayed**
execution. Package `Other`. Depends only on core **`page_cache`**. Core requirement
`^8.9 || ^9 || ^10 || ^11`. Requires the `curl` PHP extension and **Drush 9/10/11**.
License GPL-2.0-or-later. Version dir 1.0.x (release 1.0.0-rc6). **No settings UI** — edit
`custom_purge.settings` YAML and `drush cim`.

- **Config object, profiles, cache instances, domains, schema keys** →
  [config/settings.md](config/settings.md)
- **The `PurgePlugin` plugin type + the three shipped plugins (and writing your own)** →
  [plugins/purge-plugins.md](plugins/purge-plugins.md)
- **The `Purger` service API, the URL-purge form, and the two Drush commands** →
  [api/purger-and-commands.md](api/purger-and-commands.md)

## What it actually is

- One service `custom_purge.purger` (`Drupal\custom_purge\Purger`) with two public methods:
  `purgeUrls()` and `enqueuePurgeEverything()`.
- One plugin type **`PurgePlugin`** (manager `plugin.manager.custom_purge` =
  `PurgePluginManager`, dir `Plugin/custom_purge/Purge`, annotation
  `Annotation\PurgePlugin`, interface `PurgePluginInterface`, base `PurgePluginBase`).
  Shipped plugin ids: **`drupal_page_cache`**, **`varnish`**, **`cloudflare`**.
- Two queue workers: **`custom_purge_urls`** (`Plugin/QueueWorker/CustomPurgeUrls`) and
  **`custom_purge_everything`** (`CustomPurgeEverything`), both `cron` time 10s, base
  `CustomPurgeWorkerBase`.
- One route `custom_purge.url_purger` → `/admin/config/custom_purge/url_purger`, form
  `Form\UrlPurgeForm`, permission **`use custom_purge url purger`** (admin route). Menu link
  under *Configuration → System* (re-parented under Admin Toolbar's help if present, via
  `hook_menu_links_discovered_alter`).
- Two permissions (`custom_purge.permissions.yml`): `administer custom_purge settings`
  (declared; no route uses it here) and `use custom_purge url purger` (gates the form).
- Two Drush commands (`Commands\CustomPurgeCommands`, wired via `drush.services.yml`):
  `custom-purge:url` and `custom-purge:enqueue-purge-everything`.
- Config schema in `config/schema/custom_purge.schema.yml`; install default in
  `config/install/custom_purge.settings.yml` (profile `production`, one `drupal_page_cache`
  instance, one default `localhost` domain). `provides_config_schema: true`.
- Hook `hook_manual_custom_purge($urls)` (see `custom_purge.api.php`) invoked after every
  manual `purgeUrls()`. `hook_cron()` runs flood garbage collection.

## Mechanism (from source)

- `Purger::purgeUrls($urls, $caches, $enqueue, $add_delay)` groups URLs by configured domain
  (longest-domain-first match, protocol-aware; falls back to `parse_url` host then the default
  domain), then for each domain asks `PurgePluginManager::getPurgePluginsForDomain()` for the
  assigned plugins and calls `$plugin->purgeUrls()` (or queues with a delay). Skips plugins
  whose `allow_url_purge` is false. Invokes `hook_manual_custom_purge`.
- `Purger::enqueuePurgeEverything(...)` resolves domains → plugins, then for each plugin either
  runs `purgeEverything()` immediately (delay 0 or `ignore_delay_run_immediately`) or creates a
  `custom_purge_everything` queue item with `target_time = now + delay`. Skips plugins whose
  `allow_purge_everything` is false; de-dupes against items already in the queue by `item_key`.
- Queue items carry `target_time`; `CustomPurgeWorkerBase::targetTimeReached()` re-queues (with a
  1s sleep) until the delay elapses, then the worker performs the purge.
- Config is read from `custom_purge.settings` under `profiles.<active profile>.*`; the active
  profile is the top-level `profile` key.

Everything is grounded in the module source under `web/modules/contrib/custom_purge/`.
