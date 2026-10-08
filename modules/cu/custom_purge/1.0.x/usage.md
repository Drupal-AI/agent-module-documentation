<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Purge is a lightweight, plugin-based module that purges individual URLs or whole caches from Drupal's internal page cache, Varnish and Cloudflare, with optional queue-delayed execution.

---

Custom Purge models each cache target as a `PurgePlugin` plugin and drives them from a single `Purger` service. Configuration lives in one config object (`custom_purge.settings`) organized into named **profiles** (one active per environment) and, within each profile, a list of **cache instances** and **domains**. There is no configuration UI — the YAML must be edited and imported with `drush cim`. Site builders get an admin form at `/admin/config/custom_purge/url_purger` (permission `use custom_purge url purger`) to paste URLs and purge them from the caches assigned to each domain; the form is flood-limited and validates each URL. Developers and operators get two Drush commands — `custom-purge:url` and `custom-purge:enqueue-purge-everything` — plus a `custom_purge.purger` service API (`purgeUrls()`, `enqueuePurgeEverything()`) for use from code. Whole-cache and delayed purges run through two queue workers (`custom_purge_urls`, `custom_purge_everything`) processed on cron or `drush queue:run`; the per-plugin `delay_complete_purge` key decides whether a purge runs immediately or is deferred until its target time. Three plugins ship: `drupal_page_cache` (deletes page-cache CIDs / `deleteAll()`), `varnish` (sends PURGE/BAN HTTP requests pinned to a configured IP via `CURLOPT_RESOLVE`), and `cloudflare` (calls the Cloudflare v4 purge_cache API, optionally reusing the Cloudflare module's credentials). Additional targets can be added by other modules as new `PurgePlugin` plugins.

---

- Purge a set of individual URLs from all caches assigned to their domain via the admin form.
- Purge URLs from the command line with `drush custom-purge:url https://example.com/page`.
- Purge multiple URLs at once by comma-separating them in the Drush command.
- Restrict a purge to one cache type with `--cache-type=varnish` (or `cloudflare`).
- Restrict a purge to one named cache instance with `--cache-name=my_varnish`.
- Purge everything from every configured cache with `drush custom-purge:enqueue-purge-everything`.
- Purge everything for a single domain with `--domain=example.com`.
- Defer a whole-cache purge by configuring `delay_complete_purge` seconds per cache instance.
- Add extra delay to a queued purge with `--add-delay=3600`.
- Force an immediate whole-cache purge (ignoring configured delays) with `--ignore-delay-run-immediately`.
- Drop and rebuild the pending purge queue with `--reset-queue`.
- Re-enqueue items even if already queued with `--ignore-existing-items`.
- Invalidate Drupal's internal page cache for specific URLs, with configurable CID extensions (`:`, `:html`, `:json`, ...).
- Send PURGE/BAN requests to a Varnish instance addressed by IP and port without changing DNS.
- Purge single Varnish objects with a custom HTTP method (default PURGE) and extra headers.
- Ban the whole Varnish cache with a custom method (default BAN), URL and headers.
- Purge Cloudflare by URL list (chunked to 100) or purge everything for a zone.
- Reuse the Cloudflare module's zone_id/email/apikey, or supply them in Custom Purge config.
- Run multiple named cache instances of the same type (e.g. several Varnish backends) per profile.
- Route different domains to different cache instances via per-domain `assigned_cache_instances`.
- Switch entire cache topologies between environments by changing the active `profile`.
- Flood-limit how many URL entries an operator can purge per interval (`flood_limit` / `flood_interval`).
- Cap how many URLs a single form/request may purge with `max_url_per_request`.
- Schedule periodic queue draining with `drush queue:run custom_purge_urls` / `custom_purge_everything`.
- React to manual URL purges from other modules via the `hook_manual_custom_purge()` hook.
- Add a new cache backend (Redis, another CDN, etc.) by implementing a `PurgePlugin`.
