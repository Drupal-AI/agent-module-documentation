<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LSCache — configure

LiteSpeed Cache integration: emits `X-LiteSpeed-Tag` and
`X-LiteSpeed-Cache-Control` headers on cacheable responses (via
`LscacheResponseSubscriber`) so LSWS caches Drupal pages keyed by Drupal cache tag,
and (with the `lscache_purger` submodule + Purge) invalidates them on content change.

## Prerequisite: .htaccess
Header emission alone does nothing until LSWS sees a `CacheLookup` directive:
```apache
<IfModule LiteSpeed>
  CacheLookup public on
  php_flag output_buffering off
</IfModule>
```
The Status report (`/admin/reports/status`) has an **LSCache .htaccess directives**
row that reports OK / warning / error for these.

## Main settings
Route `lscache.settings` — `/admin/config/development/performance/lscache`
(permission `administer lscache`, `restrict access: true`). Config `lscache.settings`:
- **enabled** — toggle header injection (default off; enable after LSWS is confirmed).
- **default_ttl** — seconds, sent as `X-LiteSpeed-Cache-Control: public,max-age=N` (0 suppresses).
- **tag_prefix** — prepended to every emitted tag (scope multiple sites on one cache).
- **private_cache** — per-user caching of authenticated pages; derives from Drupal
  cache contexts (`user`, `user.permissions`, `user.roles`, `session`); needs
  `CacheLookup public on private on`.
- **vary_cookies** — one cookie name per line → `X-LiteSpeed-Vary: cookie=NAME`
  (needs a matching server-side `CacheVary` directive).
- **debug** — logs the tag payload per response on the `lscache` channel.

## Purger submodule (needs drupal/purge)
`drush en lscache_purger` auto-wires a Purge pipeline (coretags queuer + cron/
lateruntime processors). Set the purge host at
`/admin/config/development/performance/lscache/purger` (origin-direct URL such as
`http://127.0.0.1`, not a CDN URL). 1.3.x adds a **Host header override**
(`purge_host_header`), a **URL-based PURGE strategy** (`purge_strategy`: tag/url/auto,
default auto), a self-populating tag-affinity table + `static_url_map` for listing
pages, and Drush `lscache:diag` / `lscache:list-tag-coverage`.

## ESI fragments (1.2.x+)
Render element `#type => 'lscache_esi'` with `#callback` (like `#lazy_builder`) and
`#args` emits `<esi:include src="/lscache-fragment/{token}" />`; see api/lscache.md.
