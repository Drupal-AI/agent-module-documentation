<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache Utility (cache_utility) — agent index

Exposes cache operations as authenticated HTTP JSON endpoints, Drush commands, and a settings-form
UI: clear and inspect Drupal's `cache_*` tables, the `cachetags` table, PHP **OPcache** and **APCu**.
The point is that OPcache and APCu are per-PHP-process, so a load-balanced or containerised deploy
can flush them on each web node with a `curl` call — something `drush cr` alone cannot reach.
No module dependencies; core `^10 || ^11`.

Settings route: `cache_utility.settings` → `/admin/config/development/cache_utility`
(permission `administer cache utility configuration`). Config object: `cache_utility.settings`.
Defines 1 permission and 10 Drush commands; no plugin types; ships no config schema.
Submodule: `cache_utility_admin_toolbar` (adds flush links under Admin Toolbar Extras).

## What you'd do
- **Set the access key and choose which caches piggyback on `drush cr`** → [configure/settings.md](configure/settings.md)
- **Call the HTTP JSON API (clear / status / config per cache)** → [api/http-endpoints.md](api/http-endpoints.md)
- **Run cache operations from Drush** → [drush/commands.md](drush/commands.md)
- **Add flush links to the admin toolbar** → [api/admin-toolbar.md](api/admin-toolbar.md)
- **The permission it defines** → [permissions/permissions.md](permissions/permissions.md)

## Key facts
- Config object `cache_utility.settings` — keys: `security.accessKey`, `flushCaches.opcache`,
  `flushCaches.apcu`, `flushCaches.drupal_cachetags`, `flushCaches.drupal_cachetables`,
  `skip_ssl_verification`.
- API auth: every JSON route requires a `CU-ACCESS-KEY:` request header equal to
  `security.accessKey`. `hook_install()` seeds that key with `Crypt::randomBytesBase64(32)`.
- Permission `administer cache utility configuration` gates the settings form and the submodule's
  toolbar routes (the submodule routes also require `_csrf_token`).
- 11 JSON API routes under `/admin/cache_utility/…` (all GET) + 1 settings route.
- Drush command prefix `cache_utility:` / `cu:` — 10 commands, each accepts `--host`.
- Runtime hook: `hook_cache_flush()` resets/clears the enabled `flushCaches.*` targets on every
  `drupal_flush_all_caches()`.
