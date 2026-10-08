<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Static Asset Cache Buster appends a cache-busting query string to rendered image and file URLs, so replacing a file at the same path actually reaches visitors instead of being served from a browser or CDN cache indefinitely.

---

Drupal reuses a file's URI when a file is replaced in place, and image derivatives keep their generated path. A browser or CDN that cached the old bytes with a long TTL will keep serving them, which is why "I uploaded the new logo but it still shows the old one" is a perennial support ticket. This module attaches a version marker — derived from the file's own metadata, so it changes when the file changes — to the rendered URL. Everything lives in `static_asset_cache_buster.module` plus `src/Plugin` and `src/Entity`; there are no routes, permissions, configuration forms or dependencies beyond core, and the release targets `^10 || ^11`. The important consequence to weigh is on the CDN side: changing the query string creates a *new* cache key, so old versions stay resident in the CDN until they expire, and a site that replaces many files frequently will see cache-hit ratios dip while the new URLs warm. That is the intended trade — correctness over hit rate.

---

- Force browsers to fetch a replaced image.
- Stop a CDN serving a stale logo.
- Bust cache when a PDF is updated in place.
- Avoid renaming files just to defeat caching.
- Keep long cache TTLs while still updating assets.
- Fix "the old image still shows" support tickets.
- Update a downloadable document without a new URL.
- Serve fresh image derivatives after a change.
- Keep file paths stable for external links.
- Refresh assets after a bulk file replacement.
- Support aggressive edge caching safely.
- Ensure printed collateral links stay valid.
- Update a favicon or brand asset reliably.
- Reduce manual cache purges.
- Keep referenced file URLs consistent in content.
- Apply busting across all rendered file URLs.
- Deploy an asset change without a CDN purge.
- Handle in-place file replacement workflows.
