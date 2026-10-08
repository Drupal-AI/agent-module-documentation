# Services: Iconify API client & icon cache

Two services, both public.

## `iconify_icons.iconify_api`

`Drupal\iconify_icons\IconifyApi` implements `IconifyApiInterface`.
Constructor args: `@http_client`, `@logger.channel.default`, `@iconify_icons.icons_cache`,
`@cache.default`.

All calls target hardcoded HTTPS endpoints on `https://api.iconify.design` (constants on the class):
`SEARCH_API_ENDPOINT` `/search`, `COLLECTION_API_ENDPOINT` `/collection`,
`COLLECTIONS_API_ENDPOINT` `/collections`, `DESIGN_DOWNLOAD_API_ENDPOINT` `/%s/%s.svg`,
`API_VERSION` `/version`. Every method catches its own Guzzle/JSON exceptions, logs, and returns an
empty value on failure (so callers never see an exception from these methods despite the docblock
`@throws`).

| Method | Returns | Notes |
|--------|---------|-------|
| `getIcons(string $query, string $collection, int $limit = 10)` | `array` | Search icons (`/search?query=&prefixes=`). Returns `data['icons']`. |
| `getCollections()` | `array` | Full collections list. **Cached** in `cache.default` under cid `iconify_icons:collections` for `COLLECTIONS_CACHE_TTL = 86400` s (1 day). Used by the settings form. |
| `getIconsByCollection(string $collection)` | `array` | Icon slugs in a collection (`/collection?prefix=`); flattens `categories`, falls back to `uncategorized`. Used by the extractor's `discoverIcons()`. |
| `generateSvgIcon(string $collection, string $icon_name, array $parameters = [])` | `string` | Fetches one SVG (async `requestAsync()->wait()`); reads/writes the disk cache. Returns raw SVG or `''`. |
| `generateSvgIcons(array $icons, array $parameters = [])` | `array` | Batch of `collection:name` ids; parallel requests via `GuzzleHttp\Promise\Utils::unwrap()`; each cached. |
| `getIconSource(string $collection, string $icon_name, array $parameters = [])` | `string` | Builds the `/{c}/{i}.svg?width=&height=&color=&flip=&rotate=` URL (no HTTP call). |
| `getApiVersion()` | `string` | The Iconify API version string (shown on the module help page). |

`setDefaultParameters()` (protected) fills `width`/`height` = 25, `color` = `currentColor`,
`flip`/`rotate` = `''` when a parameter is omitted.

Note: in 2.0.x the **render path uses only the `source` URL** (built from `DESIGN_DOWNLOAD_API_ENDPOINT`)
so the icon is fetched by the browser; `generateSvgIcon*` / `getIconSource` and the disk cache below
are available for programmatic use but are not on the icon-pack render path.

### Example

```php
$api = \Drupal::service('iconify_icons.iconify_api');
$slugs = $api->getIconsByCollection('mdi');           // ['ab-testing', 'account', ...]
$svg   = $api->generateSvgIcon('mdi', 'home', ['width' => 48, 'color' => '#f00']);
$url   = $api->getIconSource('mdi', 'home', ['width' => 24]);
```

## `iconify_icons.icons_cache`

`Drupal\iconify_icons\IconsCache` implements `IconsCacheInterface`. Constructor arg: `@file_system`.
A **file-system** cache of fetched SVGs (used only by `generateSvgIcon*`), keyed by every render
parameter:

```
public://iconify-icons/{collection}/{icon}/{width}/{height}/{color}/{flip}/{rotate}/{icon}.svg
```

| Method | Behavior |
|--------|----------|
| `checkIcon($collection, $icon_name, $parameters): bool` | Whether the cached `.svg` file exists. |
| `getIcon($collection, $icon_name, $query_options): string` | `file_get_contents()` of the cached file, or `''`. |
| `setIcon($collection, $icon_name, $icon, $parameters): bool` | Creates the dir and writes the SVG (`FileExists::Replace`). |
