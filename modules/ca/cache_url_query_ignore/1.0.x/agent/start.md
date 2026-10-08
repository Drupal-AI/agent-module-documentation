<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache URL Query Ignore (cache_url_query_ignore) — agent index

Decorates Drupal core's **`cache_context.url`** service so that configured query parameters are
removed from (or are the only ones kept in) the `url` cache-context key. Purpose: collapse URL
variants that differ only by tracking params (`gclid`, `fbclid`, `utm_*`) into one cache entry,
raising hit rates and shrinking the cache. Package **Performance**. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.0. No dependencies, no module-specific permissions, no Drush, no
entities, no plugin types.

- **The one service decorator, the config form, config object/schema, and how it works** →
  [config/settings.md](config/settings.md)

## What it actually is

- One service, `cache_context.url.decorator` (`cache_url_query_ignore.services.yml`): class
  `UrlQueryIgnoreCacheContext` in `src/Cache/Context/UrlQueryIgnoreCacheContext.php`, which
  **decorates** core `cache_context.url` (`decoration_priority: 10`, inner injected as
  `cache_context.url.inner`) and extends `Drupal\Core\Cache\Context\UrlCacheContext`. It overrides
  `getContext()` to run the inner context's value through `clean()`.
- One settings form, `UrlCacheQueryIgnoreSettings` (`src/Form/UrlCacheQueryIgnoreSettings.php`),
  a `ConfigFormBase` using `RedundantEditableConfigNamesTrait`, form id `cache_url_query_ignore_form`.
- One config object, **`cache_url_query_ignore.settings`**, keys `query_parameters` (string,
  newline-separated) and `ignore_action` (`exclude` | `include`). Schema in
  `config/schema/cache_url_query_ignore.schema.yml`; install defaults in `config/install/`.
- Route **`cache_url_query_ignore.admin`** → `/admin/config/development/performance/cache-url-query-ignore`,
  permission **`administer site configuration`**; menu + local task under core's
  *Performance* settings (`system.performance_settings`).

## Mechanism (from source)

- `getContext()` returns `$this->clean($this->inner->getContext())` — it does not recompute the URL,
  it rewrites the string the core context already produced.
- `clean()`: `UrlHelper::parse($value)`; if there is no query string it returns the value unchanged.
  It reads config `query_parameters`, `explode("\n", …)` then `array_map('trim', …)`.
  - Mode `include`: `array_intersect_key($query, array_flip($params))` — keeps ONLY the listed
    params in the key (everything else is dropped).
  - Mode `exclude` (default): `UrlHelper::filterQueryParameters($query, $params)` — drops the listed
    params from the key.
  - Rebuilds `path` + `?` + `UrlHelper::buildQuery($request_query)` (only if any params remain).
- Net effect: two requests whose query strings differ only in ignored params share one cache entry.

## Operating notes

- Config default: `query_parameters: "gclid\r\nfbclid"`, `ignore_action: exclude`.
- Only ignore parameters that do **not** change the rendered output for the affected caches; in
  `include` mode remember that any param NOT listed is dropped from the key.
- Affects **all** consumers of the `url` cache context (page cache, dynamic page cache, render/block
  cache), unlike the sibling Page Cache Query Ignore which touches only the internal page cache.
- Rebuild caches after changing the parameter list (`drush cr`) so old keys are not reused.

## Tests (reference behavior)

`tests/src/Unit/Cache/Context/UrlQueryIgnoreCacheContextTest.php` (both modes),
`tests/src/Kernel/CacheUrlQueryIgnoreKernelTest.php` (service decoration), and
`tests/src/Functional/CacheUrlQueryIgnoreSettingsFormTest.php` (the config form).
