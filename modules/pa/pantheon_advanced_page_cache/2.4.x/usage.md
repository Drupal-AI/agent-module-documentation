Pantheon Advanced Page Cache bridges Drupal's cache-tag system to Pantheon's Global CDN edge cache, so entity changes automatically purge exactly the right pages from the edge.

---

The module translates Drupal 8+ cache metadata into Pantheon's edge caching. On every cacheable main response it adds a `Surrogate-Key` HTTP header listing the page's cache tags, which lets Pantheon's Varnish/edge layer associate cached responses with those tags. When Drupal invalidates cache tags (for example on entity save), a custom `CacheTagsInvalidator` service calls Pantheon's `pantheon_clear_edge_keys()` to purge exactly the matching edge-cached pages — giving long edge TTLs without stale content. Because the `Surrogate-Key` header has a byte-length ceiling (default 25000), the response subscriber trims the tag list and logs a warning if a page carries too many tags. A `hook_file_update()` implementation also clears edge paths for updated files and every image style derivative, so replaced images serve fresh immediately. Two config keys tune behavior: `surrogate_key_header_limit` (used on non-Pantheon environments) and the legacy `override_list_tags` flag (defaults off; the old 1.x behavior of renaming `_list` tags is no longer recommended). The module has no admin UI and is incompatible with `big_pipe`. It is effectively required for correct caching on Pantheon-hosted Drupal sites.

---

- Serve long-lived edge-cached pages on Pantheon without stale content.
- Automatically purge only affected pages from the CDN when a node is saved.
- Emit `Surrogate-Key` headers so Pantheon's edge can tag-invalidate responses.
- Clear edge cache for a file and all its image-style derivatives when the file changes.
- Get near-instant cache clears keyed to Drupal cache tags instead of full flushes.
- Avoid 502 errors by trimming oversized surrogate-key headers automatically.
- Tune the surrogate-key header size limit for local/non-Pantheon environments.
- Diagnose over-tagged pages via the logged warning when tags are trimmed.
- Keep views/listings fresh as content is added (default list-tag behavior).
- Opt into legacy `_list` tag override behavior for backward compatibility.
- Support high-traffic sites that rely on the Pantheon Global CDN.
- Reduce origin PHP load by keeping pages cached at the edge longer.
- Ensure image replacements are visible immediately across all styles.
- Integrate Drupal cache invalidation with Varnish surrogate keys.
- Provide correct anonymous-user caching for content-heavy Pantheon sites.
- Debug caching behavior through the module's dedicated logger channel.
- Run safely alongside standard Drupal Dynamic Page Cache / Internal Page Cache.
- Lower the header limit locally to simulate edge constraints during development.
- Keep decoupled/JSON:API responses edge-cacheable with proper surrogate keys.
- Guarantee cache correctness after bulk content imports.
- Prevent unnecessary full-site cache clears on routine entity edits.
- Provide a drop-in performance layer with no content-model changes.
