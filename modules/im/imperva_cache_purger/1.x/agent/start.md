<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imperva Cache Purger (imperva_cache_purger) — agent index

A **Purge purger plugin** that propagates Drupal cache invalidations to the **Imperva
(Incapsula) CDN/WAF edge** via Imperva's REST API. Package `Purge`. Depends on the
**`purge`** module. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.1 (dir 1.0.x). No submodules, no permissions, no Drush, no config schema,
no `*.routing.yml`.

## What it provides

- **Purger plugin** `ImpervaCachePurger` (id **`imperva_cache_purger`**, label *"Imperva
  cache Purger"*) in `src/Plugin/Purge/Purger/ImpervaCachePurger.php`, extending
  `PurgerBase`. `multi_instance = FALSE`, `types = {"path","wildcardpath","everything","tag"}`,
  `cooldown_time = 0.0`, `getTimeHint()` = 4.0s. Its `configform` annotation points at the
  config form below. → [plugins/purger.md](plugins/purger.md)
- **Invalidator service** `imperva_cache_purger.invalidator` =
  `Drupal\imperva_cache_purger\ImpervaCacheInvalidator` (arg `@http_client`) — builds and
  sends the Imperva API `DELETE` requests. → [api/imperva-invalidator.md](api/imperva-invalidator.md)
- **Config form** `ImpervaCachePurgerConfigForm` (`src/Form/`), extends purge_ui's
  `PurgerConfigFormBase`; edits config object **`imperva_cache_purger.settings`**. Surfaced
  through Purge's admin UI at `/admin/config/development/performance/purge`. →
  [config/settings.md](config/settings.md)
- **Response subscriber** `imperva_cache_purger.send_cache_tags` =
  `EventSubscriber\SendCacheTags` — on `KernelEvents::RESPONSE` for main requests it sets a
  `Cache-Tag` header (comma-joined cache tags) on any `CacheableResponseInterface` response.

## Mechanism (from source)

- Purge calls `ImpervaCachePurger::invalidate()`. It sorts invalidations into `$paths` and
  `$tags`; an `EverythingInvalidation` resets paths to `['^/']`; path/wildcard expressions are
  normalised with a leading slash and `htmlentities()`; tag expressions collected as-is;
  unsupported types get `NOT_SUPPORTED`. Empty set → logs and returns.
- If `settings.disabled` is set, it logs and marks all invalidations `SUCCEEDED` **without**
  calling Imperva (a no-op mode for non-prod). Otherwise it calls the invalidator inside a
  try/catch: success → `SUCCEEDED`, exception → logged via `Error::decodeException` and `FAILED`.
- `ImpervaCacheInvalidator::invalidate()` sends **one `DELETE` per path and per tag** to
  `getApiEndpoint()` = `{api_endpoint or my.imperva.com/api/prov/v2/sites/}{site_id}/cache`,
  with query `url_pattern=` (paths) or `tags=` (tags) and headers `x-api-key`, `x-api-id`,
  `Content-Type: application/json`. Uses Drupal's `@http_client` (Guzzle). Which requests
  fire depends on `purger_type` (`path`, `cache_tag`, or `path_cache_tag`).

## Install / operate

1. `composer require drupal/imperva_cache_purger`, enable `purge` + `imperva_cache_purger`.
2. Configure a Purge queue + processor (see the Purge module).
3. Go to `/admin/config/development/performance/purge`, add/enable the *Imperva cache Purger*,
   then **Configure** it: API ID, API key, site id, invalidation type, optional endpoint.
   Details + config keys → [config/settings.md](config/settings.md).
