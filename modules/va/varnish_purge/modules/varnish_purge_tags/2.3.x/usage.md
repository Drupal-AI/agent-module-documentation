Varnish Purger Tags is a tiny submodule of Varnish Purger that emits a `Cache-Tags` response header on cacheable responses, so Varnish can `BAN` cached pages by Drupal cache tag.

---

Varnish Purger Tags provides a single Purge `@PurgeTagsHeader` plugin, `varnish_tagsheader`, whose entire job is to add a `Cache-Tags` header (containing the page's Drupal cache tags) to every cacheable response. Varnish stores that header alongside the cached object, and when Drupal invalidates a tag the Varnish purgers issue a `BAN` request carrying `Cache-Tags`, letting Varnish evict exactly the pages that reference that tag rather than flushing everything. The plugin class (`CacheTags`) is a near-empty subclass of Purge's `TagsHeaderBase` — the header name `Cache-Tags` is declared entirely in the plugin annotation. It has no configuration and no admin page; enabling the module is all that is required. It depends on the main `varnish_purger` module and is normally used together with a tag-type `varnish`/`varnishbundled` purger (or the zero-config purger). This is the standard way to enable accurate tag-based cache invalidation for a Varnish-fronted Drupal site.

---

- Add a `Cache-Tags` response header to cacheable pages so Varnish can ban by cache tag.
- Enable accurate tag-based Varnish invalidation instead of full-site cache flushes.
- Pair with a `varnish` purger configured for `BAN` + `Cache-Tags: [invalidation:expression]`.
- Let Varnish evict only the pages carrying an invalidated tag (e.g. `node:5`, `node_list`).
- Support the shipped `zeroconfig.vcl`, which reads the pipe-separated `Cache-Tags` header on `BAN`.
- Turn on tag support with a single `drush en varnish_purge_tags` — no configuration needed.
- Expose each rendered page's Drupal cache tags to the reverse proxy for fine-grained clearing.
- Keep Varnish caches consistent when a referenced entity (node, term, media) is edited.
- Invalidate list pages (via `*_list` tags) when their member content changes.
- Work with Purge's cache-tags queuer so tag invalidations are queued the moment content is saved.
- Avoid over-purging by clearing per-tag rather than per-URL or whole-cache.
- Provide the header without writing any custom Varnish header logic in Drupal.
- Use alongside CDNs/reverse proxies that understand a `Cache-Tags` header.
- Serve as the response-header half of a Varnish tag-invalidation pipeline (Varnish Purger being the request half).
- Drop in on any Drupal 8/9/10/11 site that already runs Varnish Purger.
