<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generic HTTP Tags Header is a tiny submodule of Generic HTTP Purger that adds a single Purge TagsHeader plugin so Drupal emits a `Purge-Cache-Tags` response header listing each response's cache tags, letting a reverse proxy or CDN under your control invalidate content by tag.

---

The submodule provides exactly one plugin: `PurgeCacheTagsHeader` (`@PurgeTagsHeader(id = "purge_tagsheader", header_name = "Purge-Cache-Tags")`, extending purge's `TagsHeaderBase`). Purge core's tags-header subscriber picks up every enabled TagsHeader plugin and attaches its header to cacheable responses, so once this module is enabled each response carries a `Purge-Cache-Tags` header containing the space-separated Drupal cache tags for that page. A downstream cache (Varnish with a tag-aware VCL, an nginx proxy, or a CDN) can then read that header, remember which tags a cached object depends on, and drop the right objects when Drupal later issues a tag invalidation (for example through the Generic HTTP Purger's `BAN` request). The plugin has no settings, form, route, permission, config, or Drush command — enabling the module is the whole configuration — and it depends only on `purge`. As its description warns, you only need it for custom setups under your own control where the proxy is configured to consume the header.

---

- Emit a `Purge-Cache-Tags` response header so a tag-aware Varnish can map cached objects to Drupal cache tags.
- Let a custom reverse proxy invalidate by cache tag using the tags exposed in the header.
- Pair with Generic HTTP Purger's `BAN` purger to build a full tag-based external cache-invalidation pipeline.
- Expose cache tags to a CDN edge that supports tag/surrogate-key purging.
- Give an nginx + proxy_cache setup the tag metadata it needs for selective purging.
- Debug which cache tags a page depends on by reading the `Purge-Cache-Tags` header in responses.
- Drive surrogate-key style invalidation on a self-hosted caching layer.
- Provide the header input a custom VCL uses to store `obj.http.Purge-Cache-Tags`.
- Enable tag-based invalidation without writing a custom TagsHeader plugin yourself.
- Keep the proxy's cached copies fresh when a node/term/menu changes, by tag rather than by URL.
- Combine with Purge's queue + processors so tagged content is invalidated in the background.
- Standardise the response header name (`Purge-Cache-Tags`) across environments for your proxy config.
- Turn on tag exposure only where you control the proxy, per the module's own guidance.
- Use it as the header source for a Fastly/Cloudflare-style tag purge in a bespoke integration.
- Verify tag propagation end-to-end while building a decoupled/edge-cached architecture.
- Replace an ad-hoc custom cache-tags header module with the maintained purge submodule.
