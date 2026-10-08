<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Purge — the `PurgePlugin` plugin type

Each cache target is a **`PurgePlugin`** plugin. This is the module's extension point: add a new
cache backend (Redis, Fastly, another CDN) by shipping your own plugin.

## The plugin type

- **Manager**: `plugin.manager.custom_purge` = `Plugin\PurgePluginManager` (extends
  `DefaultPluginManager`). Subdir `Plugin/custom_purge/Purge`, interface
  `Plugin\PurgePluginInterface`, annotation `Annotation\PurgePlugin` (`id`, `label`), alter hook
  `custom_purge_plugin`, cache key `custom_purge_plugin`. It also has a
  `setConfigFactory()` call (wired in `custom_purge.services.yml`).
- **Annotation** example: `@PurgePlugin(id="varnish", label="Varnish")`.
- **Interface** `PurgePluginInterface` (extends `PluginInspectionInterface`):
  - `purgeUrls(array $urls): array` — returns `['processed' => [...], 'errors' => [...]]`.
  - `purgeEverything(): bool` — whole-instance purge success flag.
  - `getPurgePluginSettings(): PurgePluginSettings`.
- **Base** `Plugin\PurgePluginBase` (`PurgePluginBase implements PurgePluginInterface,
  ContainerFactoryPluginInterface`): stores config into a `PurgePluginSettings` value object,
  provides static helpers `httpClient(array $config)` (via `http_client_factory` →
  `fromOptions()`) and `logger()` (channel `custom_purge`).
- **`PurgePluginSettings`** (value object over one `cache_instances` entry):
  `getCacheType()`, `getCacheName()`, `isAllowedToPurgeSingleUrls()`,
  `isAllowedToPurgeEverything()`, `getDelayCompletePurge()`, generic `get($key, $default)`.

## Domain-sensitive plugins

A plugin that must act per-domain implements `Plugin\DomainSensitiveCacheInterface` (helper
`DomainSensitiveCacheTrait`). The manager then calls `setDomainSettings(new DomainSettings(...))`
so the plugin can read `getDomain()` / `getDefaultProtocol()`. `PurgePluginManager` caches such
plugins under a domain-sensitive key `cache_name__protocol__domain`, and the `Purger` scopes a
purge-everything to the plugin's single domain. **Varnish is domain-sensitive**; Cloudflare and
the page-cache plugin are not.

## How the manager resolves plugins

`PurgePluginManager::getPurgePluginsForDomain($domain, $caches)`:
1. Finds the domain's `assigned_cache_instances` (or the default domain's).
2. For each assigned `cache_name`, finds the matching `cache_instances` entry and applies the
   optional `$caches` filter (`['type' => ...]` and/or `['name' => ...]`, string or array).
3. Instantiates the plugin id (`cache_type`) with that entry as configuration, caching it
   (domain-sensitively when applicable).

## Shipped plugins

### `drupal_page_cache` — `Plugin/custom_purge/Purge/DrupalPageCachePurgePlugin`
Purges core's internal page cache. `create()` injects `cache.page` (warns via log if absent).
`purgeUrls()` builds CIDs by appending each `cid_extensions` suffix to each URL and calls
`deleteMultiple()`. `purgeEverything()` calls `deleteAll()`. Not domain-sensitive.

### `varnish` — `Plugin/custom_purge/Purge/VarnishPurgePlugin`
Domain-sensitive. Builds Guzzle clients via `PurgePluginBase::httpClient()` with
`connect_timeout 2s`, `timeout 3s`, and `CURLOPT_RESOLVE => ["domain:port:ip"]` so requests hit
the configured Varnish IP without DNS changes. `verifyhost`/`verifypeer` default **true**;
setting either to false disables the corresponding cURL TLS check, and disabling both also sets
Guzzle `verify => false`. Extra `single`/`everything` `http_headers` are parsed `Name: value`.
`purgeUrls()` sends one request per URL with method `single.http_method` (default `PURGE`).
`purgeEverything()` sends `everything.http_method` (default `BAN`) to `everything.url` (relative
paths are prefixed with the domain + protocol). Success = 2xx.

### `cloudflare` — `Plugin/custom_purge/Purge/CloudflarePurgePlugin`
Not domain-sensitive. `create()` reads `zone_id`/`email`/`apikey` either from the contrib
**Cloudflare** module's `cloudflare.settings` (when `use_cf_settings` and that module exists) or
from this plugin's own config; logs an error if any is empty (`settingsOk`). Client sends
`X-Auth-Email` + `X-Auth-Key` (default Guzzle TLS verification, 2s/3s timeouts) to
`https://api.cloudflare.com/client/v4/zones/<zone_id>/purge_cache`. `purgeUrls()` POSTs
`{"files": [...]}` in chunks of 100; `purgeEverything()` POSTs `{"purge_everything": true}`.
Success = 2xx.

## Writing your own

Create `src/Plugin/custom_purge/Purge/MyCachePurgePlugin.php` extending `PurgePluginBase`,
annotate `@PurgePlugin(id="my_cache", label="My cache")`, implement `purgeUrls()` and
`purgeEverything()`. Reference it from `cache_instances` with `cache_type: my_cache`. Implement
`DomainSensitiveCacheInterface` (use `DomainSensitiveCacheTrait`) if it must act per-domain.
