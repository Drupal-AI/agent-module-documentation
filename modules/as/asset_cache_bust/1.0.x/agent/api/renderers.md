<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Renderer override & cache-bust append

## Install / enable
`drush en asset_cache_bust -y`. No configuration follows — there is no settings form, permission, or config object. Uninstalling restores core behavior. Effect is only visible when CSS/JS aggregation is enabled and assets are rendered.

## Service override
`src/AssetCacheBustServiceProvider.php` — `AssetCacheBustServiceProvider::alter(ContainerBuilder $container)` runs at container-compile time and re-points two core services to this module's subclasses:

- `asset.css.collection_renderer` → `Drupal\asset_cache_bust\AssetCachingCSSCollectionRenderer`
- `asset.js.collection_renderer`  → `Drupal\asset_cache_bust\AssetCachingJSCollectionRenderer`

It uses `$container->getDefinition(...)->setClass(...)`, so all constructor arguments/dependencies of the core services are preserved. (Note: because it swaps the class name after `drush cr`, a container rebuild is required for enable/disable to take effect — this happens automatically on cache rebuild.)

## Query-string append logic
Both renderers extend the core renderer, call `parent::render(...)` first, then post-process the returned render elements.

`AssetCachingCSSCollectionRenderer::render(array $css_assets)` (`src/AssetCachingCSSCollectionRenderer.php`):
1. `$elements = parent::render($css_assets);`
2. Resolve the query string: `\Drupal::service('asset.query_string')->get()` if that service exists (D10.1+), else `\Drupal::state()->get('system.css_js_query_string', '0')`.
3. For each element, skip external hrefs (`UrlHelper::isExternal(...)`); otherwise append the query string, using `&` if the href already contains `?`, else `?`.

`AssetCachingJSCollectionRenderer::render(array $js_assets)` (`src/AssetCachingJSCollectionRenderer.php`): same pattern, keyed on `#attributes['src']`, and it additionally guards `!empty($el['#attributes']['src'])` (inline `<script>` elements have no `src` and are skipped).

## What gets modified
- Only **internal** aggregated CSS `href` / JS `src` URLs. External URLs are untouched.
- The appended value is core's own asset query string — it changes on every full cache flush/update, which is what forces re-fetch. The module adds no new source of the value.

## Verify
With aggregation on, rebuild caches (`drush cr`) and load a page; view source and confirm local `<link rel=stylesheet>` / `<script src>` aggregate URLs carry a `?<hash>` (or `&<hash>`) suffix. Clearing caches again bumps the hash, changing the URLs.

## Notes for agents
- No API to call, extend, or configure; behavior is automatic once enabled.
- To customize the value, you would subclass these renderers again in another service provider — this module intentionally reuses core's query string.
