<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cache URL Query Ignore — service decorator + settings

Everything the module does: decorate the `url` cache context and let an admin choose which query
params it ignores. No dependencies, no permissions beyond core, no Drush, no plugins.

## Install / enable

`drush en cache_url_query_ignore -y`. On enable, `config/install/cache_url_query_ignore.settings.yml`
seeds the config object with `query_parameters: "gclid\r\nfbclid"` and `ignore_action: exclude`.
Nothing else is registered — the behavior takes effect immediately because the service decorator is
declared in `cache_url_query_ignore.services.yml`.

## The service decorator

`cache_url_query_ignore.services.yml`:

```yaml
cache_context.url.decorator:
  class: Drupal\cache_url_query_ignore\Cache\Context\UrlQueryIgnoreCacheContext
  decorates: cache_context.url
  decoration_inner_name: cache_context.url.inner
  decoration_priority: 10
  arguments: ['@cache_context.url.inner', '@config.factory']
  tags: [{ name: cache.context }]
```

`UrlQueryIgnoreCacheContext` (`src/Cache/Context/UrlQueryIgnoreCacheContext.php`) extends core
`UrlCacheContext`. Constructor stores the decorated inner context and loads
`$config_factory->get('cache_url_query_ignore.settings')` into `$this->config`.

- `getContext(): string` → `return $this->clean($this->inner->getContext());`
  It transforms the string the core context already computed; it does not re-derive the URL from the
  request.
- `clean(string $value): string` (private):
  1. `$request_parts = UrlHelper::parse($value);` — if `$request_parts['query']` is empty, return
     `$value` unchanged (path-only URLs are untouched).
  2. `$params = array_map('trim', explode("\n", $this->config->get('query_parameters')));` — the
     configured list, one param per line, whitespace/`\r` trimmed.
  3. If `ignore_action === 'include'`: `array_intersect_key($request_parts['query'],
     array_flip($params))` — keep ONLY the listed params.
     Else (`exclude`): `UrlHelper::filterQueryParameters($request_parts['query'], $params)` — drop
     the listed params.
  4. Rebuild `path` (+ `'?' . UrlHelper::buildQuery($request_query)` only when params remain).

The `getCacheableMetadata()` / context id (`'url'`) come from the parent class unchanged.

## Config object & schema

Config object **`cache_url_query_ignore.settings`** (schema
`config/schema/cache_url_query_ignore.schema.yml`, type `config_object`, `translatable: false`):

| key | type | constraints | meaning |
| --- | --- | --- | --- |
| `query_parameters` | string | `NotBlank` | Newline-separated parameter names. |
| `ignore_action` | string | `Choice: [exclude, include]` | `exclude` = drop these from the key; `include` = keep only these. |

Example config export:

```yaml
# cache_url_query_ignore.settings.yml
query_parameters: |
  gclid
  fbclid
  utm_source
  utm_medium
  utm_campaign
ignore_action: exclude
```

## Settings form, route, menu

- Form `UrlCacheQueryIgnoreSettings` (`src/Form/UrlCacheQueryIgnoreSettings.php`), a `ConfigFormBase`
  with `RedundantEditableConfigNamesTrait`; form id `cache_url_query_ignore_form`.
  - `query_parameters`: `#type` textarea, `#required`, `#config_target`
    `cache_url_query_ignore.settings:query_parameters`.
  - `ignore_action`: `#type` radios, `#required`, options `exclude` / `include`, `#config_target`
    `cache_url_query_ignore.settings:ignore_action`.
  - Save is handled by the config-target machinery (no custom `submitForm`).
- Route `cache_url_query_ignore.admin` (`cache_url_query_ignore.routing.yml`):
  path `/admin/config/development/performance/cache-url-query-ignore`, `_form` → the form class,
  requirement `_permission: 'administer site configuration'`.
- Menu link + local task (`*.links.menu.yml`, `*.links.task.yml`) hang off core
  `system.performance_settings` (Configuration → Development → Performance).

## Operating guidance

- Choose parameters that do not affect the rendered response for the caches that use the `url`
  context. In `exclude` mode you list the noise; in `include` mode you list the signal and every
  other param is dropped from the key.
- After editing the list, rebuild caches (`drush cr`) so previously stored keys are not reused.
- Scope: affects page cache, dynamic page cache, and render/block caching (anything with the `url`
  cache context). The sibling Page Cache Query Ignore covers only the internal page cache.
