Asset cache bust overrides Drupal's CSS and JS collection renderers so every aggregated CSS/JS URL gets a cache-busting query string that changes on each cache clear.

---

Asset cache bust is a zero-configuration performance module that swaps Drupal core's `asset.css.collection_renderer` and `asset.js.collection_renderer` services for subclasses that always append a query-string parameter (e.g. `?<hash>`) to internal aggregated CSS and JS asset URLs. The value comes from Drupal's own `asset.query_string` service (or the `system.css_js_query_string` state as a fallback) and changes on every full cache flush or update, so browsers and CDNs are forced to re-fetch fresh aggregates rather than serving a stale or truncated cached copy. This deliberately reverses the core change in drupal.org issue #3019393, which had removed the dummy query string from aggregate URLs. The module has no settings form, no routes, no permissions, and no dependencies beyond core; installing it is the entire configuration step. External asset URLs are left untouched.

---

- Bust browser cache on aggregated CSS/JS after a deploy without editing source files.
- Recover from a rare incomplete/truncated CSS or JS aggregate by just flushing caches.
- Force clients off a stale cached aggregate once the aggregate is regenerated.
- Re-add the dummy `?<hash>` query string that core removed in issue #3019393.
- Ensure a CDN fetches a new aggregate object after each cache clear.
- Avoid deployment-only workarounds (touching CSS/JS) to invalidate client caches.
- Keep asset URLs versioned so intermediary proxies revalidate on change.
- Refresh JS aggregates that a browser would otherwise keep from a previous release.
- Refresh CSS aggregates broken by a partial write during aggregation.
- Provide cache-busting with no configuration on sites that already use aggregation.
- Support Drupal 10.5+ and Drupal 11 sites needing aggregate cache invalidation.
- Leave external (off-site) CSS/JS URLs unmodified while busting local ones.
- Preserve any existing query string on an asset URL by appending with `&` instead of `?`.
- Reduce "hard refresh required" support tickets after front-end releases.
- Guarantee a new asset URL whenever `drush cr` / cache rebuild bumps the query string.
- Standardize cache-busting behavior across multiple environments via a single module.
- Complement CDN configurations that key cached objects on the full URL including query string.
- Serve as a lightweight alternative to custom render/renderer overrides for cache-busting.
- Work transparently with existing themes and libraries — no template or library changes.
- Roll back to core behavior simply by uninstalling the module.
