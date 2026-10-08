<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Asset cache bust (asset_cache_bust) — agent index

Overrides Drupal core's CSS/JS **collection renderer** services to always append a **cache-busting query string** to aggregated CSS/JS URLs. The value comes from core's `asset.query_string` service (fallback: `system.css_js_query_string` state) and changes on every cache clear, so clients/CDNs fetch new aggregates instead of stale ones. Reverses core issue #3019393.

- **Version dir:** 1.0.x (installed 1.0.6). Core `^10.5 || ^11`. Package: Content. License GPL-2.0-or-later.
- **Dependencies:** none beyond core. No Composer requirements.
- **Provides:** no routes, no permissions, no config/settings form, no config schema, no plugins, no Drush commands, no hooks. Zero configuration — install to activate.
- **Mechanism:** a `ServiceProviderInterface::alter()` swaps two core service classes at container-build time.

## Classes
- `Drupal\asset_cache_bust\AssetCacheBustServiceProvider` — `alter()` re-points `asset.css.collection_renderer` and `asset.js.collection_renderer` to the subclasses below.
- `Drupal\asset_cache_bust\AssetCachingCSSCollectionRenderer` extends core `CssCollectionRenderer`.
- `Drupal\asset_cache_bust\AssetCachingJSCollectionRenderer` extends core `JsCollectionRenderer`.

## Solution docs
- [agent/api/renderers.md](api/renderers.md) — how the service override + query-string append works, and how to operate/verify it.
