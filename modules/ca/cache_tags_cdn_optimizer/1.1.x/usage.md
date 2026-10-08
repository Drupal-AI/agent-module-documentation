Rewrites Drupal core cache tags for referenced entities into custom "reference" tags and invalidates them only when configured fields change, so a CDN or purge module clears cached pages only when something visible actually changed.

---

Cache Tags CDN Optimizer reduces over-broad cache invalidation. By default Drupal attaches a `node:123` (or `taxonomy_term:123`) cache tag to every page that renders that entity, so editing the entity purges every page referencing it — even pages where none of the changed data is shown. This module intercepts the response in an `onKernelResponse` event subscriber and rewrites the tags of *referenced* entities (everything except the entity being viewed directly) from `node:123` to `node:reference:123`. Core still purges the directly-viewed entity normally, but the "reference" variants are only invalidated by this module's own entity hooks, and only when one of the fields you selected for that content type / vocabulary actually changed value. It also can add a per-request path cache tag (to evict cached 404s once a matching alias appears) and a bundle-level `node:<bundle>:purge_all` tag so you can purge a whole bundle at once. The module itself performs no HTTP or CDN calls; it purely shapes Drupal's cache-tags header and calls `Cache::invalidateTags()`, leaving the actual purging to whatever cache/CDN/purge backend the site already uses (e.g. Purge, a reverse proxy, or a CDN that honors the Cache-Tags header). All behavior is controlled from one settings form at `/admin/config/services/cache-tags-cdn-optimizer` (permission `administer site configuration`), stored in the `cache_tags_cdn_optimizer.settings` config object.

---

- Cut CDN/reverse-proxy purge volume on high-traffic sites where entities are referenced by many pages.
- Keep a heavily-referenced entity (author, brand term, shared paragraph) from purging every referencing page on every save.
- Invalidate referencing pages only when the referenced entity's title changes, not on unrelated metadata edits.
- Track a specific set of fields per content type so only meaningful edits trigger a purge.
- Track a specific set of fields per taxonomy vocabulary the same way.
- Enable cache-tag replacement for nodes only, leaving taxonomy terms on core's default behavior.
- Enable cache-tag replacement for taxonomy terms only.
- Add a bundle-wide purge handle (`node:article:purge_all`) so you can flush every article from the CDN in one invalidation.
- Add a `url…` path cache tag to responses so a previously cached 404 can be purged once its alias is created.
- Automatically purge a cached 404 when Pathauto (or any module) inserts a matching `path_alias` entity.
- Blocklist noisy cache tags (e.g. `config:*`) so they never reach the CDN's Cache-Tags header.
- Wildcard-blocklist a whole family of tags with a trailing `*` (e.g. `user:*`).
- Manually invalidate one cache tag from the admin UI without Drush.
- Manually invalidate several cache tags at once by entering a space-separated list.
- Debug which field change caused (or did not cause) a purge by enabling debug-mode logging.
- Reduce edge-cache churn behind Varnish/Fastly/Cloudflare setups that key on Drupal cache tags.
- Preserve normal invalidation for the canonical entity page while suppressing it for reference-only appearances.
- Improve CDN hit ratios on sites with deep entity-reference graphs.
- Run without any external dependency — the module needs only Drupal core (^10 || ^11 || ^12).
- Combine with the Purge module or a CDN Cache-Tags integration, which consume the rewritten tags.
- Selectively purge referencing pages after a bulk content update by relying on per-field change detection.
