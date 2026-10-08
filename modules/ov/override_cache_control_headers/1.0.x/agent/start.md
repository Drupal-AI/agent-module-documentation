<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Override Cache Control Headers (override_cache_control_headers) — agent index

Lets an administrator force the `Cache-Control` response header on chosen URL patterns, overriding
what Drupal would otherwise compute. An admin enters `path|directives` lines (e.g.
`/sitemap.xml|must-revalidate, no-cache, private`) on a settings form; a single kernel.response
event subscriber (`OverrideCacheControlHeaders::onViewResponse`, priority **10000**) matches the
current request URI against each pattern with the core `path.matcher` service and, on the first
match, calls `$response->headers->set('Cache-Control', <directives>)`. A second textarea (and a Drush
command) support **temporary** overrides that carry an expiry in minutes: those entries live in
`State` (`override_cache_control_headers.urls_headers`), are applied by the same subscriber, and are
pruned by `hook_cron` once expired. Whenever entries are added, `hook_override_cache_control_headers`
is invoked so integrators can, e.g., purge a Varnish/CDN cache.

Note on interaction with core: the subscriber runs early (priority 10000), then Drupal core's
`FinishResponseSubscriber::onRespond` runs afterward (priority 0). For a normal `CacheableResponse`
HTML page that core deems uncacheable (logged-in user, open session, POST, kill-switch), core
re-asserts `no-cache, must-revalidate` and the override does not stick; for anonymous cacheable
pages, and for plain (non-`CacheableResponseInterface`) responses, the override that this module set
is treated as a customized header and is left in place. Choose directives per path with that in mind.

- Depends on: nothing (info.yml has no `dependencies`). `drupal/core: ^8 || ^9 || ^10 || ^11`.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Override Cache Control Headers`.
- Settings page: **yes** — `configure: override_cache_control_headers.admin`
  (`/admin/config/development/override-cache-control-headers`), under the Performance settings tree.
- Permission: **yes** — `administer override cache control headers` (`restrict access: true`).
- Drush: **yes** — `occh:set-temp-headers`. Plugin types: none. Config schema shipped: **no** (only
  a `config/install` default; no `config/schema`).

## What you'd do → where

- **Add / edit which URLs get which `Cache-Control` header (permanent or timed), input format,
  validation rules, wildcards, query-string matching, the delete-all button** →
  [configure/settings.md](configure/settings.md)
- **Understand the mechanism (event subscriber + priority, core interaction), the utility service
  methods, the State storage, the Drush command, the cron pruning and the `hook_override_cache_control_headers`
  hook** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Route: `override_cache_control_headers.admin` → `/admin/config/development/override-cache-control-headers`
  (`_permission: administer override cache control headers`, `_admin_route: TRUE`); form
  `Drupal\override_cache_control_headers\Form\OverrideCacheControlHeadersSettingsForm` (form id
  `override_cache_control_headers_configuration`). Menu/local-task links hang off
  `system.performance_settings`.
- Config object: `override_cache_control_headers.settings`, key **`urls_header`** (one `path|directives`
  per line). The temporary textarea (`urls_header_temp`) is **not** persisted to config — it is written
  to State.
- State key: `override_cache_control_headers.urls_headers` (`UtilityInterface::STATE_NAME`); each entry
  is `path|directives|minutes|start_ts|expiry_ts`.
- Services: `override_cache_control_headers_subscriber`
  (`EventSubscriber\OverrideCacheControlHeaders`, tag `event_subscriber`, listens `KernelEvents::RESPONSE`
  method `onViewResponse` priority `10000`); `override_cache_control_headers_utility`
  (`Drupal\override_cache_control_headers\Utility` implements `UtilityInterface`).
- Drush: command `override_cache_control_headers:set-temp-headers`, alias `occh:set-temp-headers`
  (service `override_cache_control_headers_drush_commands` in `drush.services.yml`).
- Permission: `administer override cache control headers` (`restrict access: true`).
- Hooks implemented: `hook_help` (renders README, via `markdown` filter if present), `hook_cron`
  (prunes expired temp headers). Hook defined for integrators:
  `hook_override_cache_control_headers(array $urls)` (see `override_cache_control_headers.api.php`).
- Path matching: core `path.matcher`.`matchPath()` — supports `*` wildcards; query strings are matched
  when the configured pattern includes a `?`, otherwise the query string is stripped before matching.
- Allowed `Cache-Control` directives (form/Drush validation allowlist): `must-revalidate`, `no-cache`,
  `no-store`, `public`, `private`, `proxy-revalidate`, `max-age`, `s-maxage`.
