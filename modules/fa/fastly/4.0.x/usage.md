Fastly integrates a Drupal site with the Fastly CDN: it maps Drupal cache tags to Fastly Surrogate Keys for tag-based purging, exposes instant/soft purge controls, and configures edge features such as stale-content serving, image optimization, VCL/edge modules, and webhooks.

---

The module registers a cache-tags invalidator that turns Drupal cache-tag invalidations into Fastly purges, and a `SurrogateKeyGenerator` event subscriber that emits `Surrogate-Key` response headers (hashed via `CacheTagsHash`, truncated to `cache_tag_hash_length` and namespaced by `site_id`) so Fastly can purge by key. Purging goes through the `fastly.api` service (`Api`) and can be `instant` or `soft` (`purge_method`), and is also exposed as Drush commands. Configuration lives in the `fastly.settings` config object and a set of forms under `/admin/config/services/fastly` (route `fastly.settings`, permission `administer fastly`): the main form (API token, Service ID, Site ID), plus Purge Options, Stale Content Options (`stale_while_revalidate`/`stale_if_error` with their `_value`s), Image Optimizer (`image_optimization`, `webp`, `jpeg_quality`, `resize_filter`, …), Webhooks (`webhook_enabled`/`webhook_url`/`webhook_notifications`), and an Edge Modules UI backed by `fastly.edge_modules.*` config (CORS headers, country block, redirects, URL rewrites, third-party integrations, …). Credentials can also come from environment variables — `FASTLY_API_TOKEN`, `FASTLY_API_SERVICE`, `FASTLY_SITE_ID`, `FASTLY_CACHE_TAG_HASH_LENGTH` — which override config when set. A `VclHandler` uploads/maintains VCL snippets (alterable via `hook_vcl_handler_data_alter()`), a `FastlyImageFormatter` renders images through the Fastly Image Optimizer, and Drupal state tracks whether the configured credentials can purge. The bundled **fastlypurger** submodule plugs this into the Purge module as a purger. Actual purging and VCL upload require valid Fastly credentials and network access; all local configuration works without them.

---

- Purge Fastly's cache by Drupal cache tag when content changes (tag → Surrogate Key).
- Emit `Surrogate-Key` headers so Fastly can invalidate exactly the affected pages.
- Purge everything on Fastly after a deployment (`drush fastly:purge:all`).
- Purge a single URL from the CLI (`drush fastly:purge:url`).
- Purge specific cache keys/tags (`drush fastly:purge:key`).
- Purge the whole Fastly service (`drush fastly:purge:service`).
- Choose instant vs soft purge to serve stale-then-revalidate on invalidation.
- Serve stale content while revalidating (`stale_while_revalidate`) to smooth origin load.
- Serve stale content if the origin errors (`stale_if_error`) for resilience.
- Store the Fastly API token as config or via the `FASTLY_API_TOKEN` environment variable.
- Select which Fastly Service the site maps to (config or `FASTLY_API_SERVICE`).
- Namespace cache tags per site with a Site ID when several sites share one Fastly service.
- Tune the Surrogate-Key hash length to keep header size under Fastly's 16 KB limit.
- Bypass the cache for requests carrying certain cookies (`cookie_cache_bypass`).
- Optimize and resize images at the edge via the Fastly Image Optimizer.
- Serve automatic WebP with a configurable quality (`webp`, `webp_quality`).
- Set default JPEG quality/format for optimized images.
- Enable Fastly Edge Modules (CORS headers, country block, URL rewrites, redirects) from the UI.
- Integrate third-party edge services (Datadome, Netacea, Blackfire) via edge modules.
- Receive Fastly webhook notifications for purge/cache events.
- Upload and maintain custom VCL snippets, altering the data with `hook_vcl_handler_data_alter()`.
- Wire Fastly into the Purge module's queue/processor with the fastlypurger submodule.
- Log purge operations for debugging (`purge_logging`).
- Verify that the configured credentials are sufficient to purge (tracked in Drupal state).
- Render a specific image field through Fastly's optimizer with the Fastly image formatter.
