<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Purge invalidates Cloudflare's CDN cache directly from Drupal — manually (by URL, cache tag, prefix, hostname, or everything) from admin forms and Drush, and automatically when Drupal cache tags are invalidated.

---

The module talks to Cloudflare's `api.cloudflare.com` purge endpoint over Drupal's Guzzle HTTP client. A `CredentialResolver` resolves credentials from three tiers in priority order — `settings.php` override (`$settings['cloudflare_purge_credentials']`), the optional Key module, then plain config — and supports both Bearer Token (recommended) and legacy Email + Global API Key auth; the Zone ID is validated as a 32-char hex string. A low-level `CloudflarePurgeApi` builds the auth headers and posts `purge_everything` / `files` / `tags` / `prefixes` / `hosts` payloads (max 100 items per request), while the higher-level `Purge` service adds credential validation, per-minute rate limiting (State API, per-server), batching, messaging, and gated logging. Manual purges are exposed as admin forms under `/admin/config/cloudflare-purge/*` (each with its own permission and CSRF protection) and as Drush commands. Automatic purging is opt-in: a `cache_tags_invalidator`-tagged service (`CloudflareCacheTagInvalidator`, priority -100) captures invalidated tags for the configured entity types; a `CacheTagFormatter` filters/prefixes/optionally hashes them; and they are either purged immediately or merged into a deduplicated `cloudflare_purge_pending_tags` table that `hook_cron` drains into a queue in Cloudflare-sized batches. An event subscriber can also emit a size-capped `Cache-Tag` response header so Cloudflare knows which tags a page carries. A history page reads recent purge log entries (needs core `dblog`), and a "Plans & Limits" page documents Cloudflare's rate limits. All state-changing routes are permission-gated; the API base URL is hardcoded to Cloudflare, so the purge forms are not a general SSRF surface.

---

- Purge the entire Cloudflare zone from Drupal after a large deployment or content migration.
- Purge specific URLs from the CDN when a handful of pages change.
- Purge by Drupal cache tag (e.g. `node:123`) to clear exactly the affected content.
- Purge by URL prefix (e.g. everything under `/blog/`) in one operation.
- Purge by hostname to clear all cached content for `cdn.example.com`.
- Automatically purge Cloudflare whenever matching Drupal entities (node/taxonomy/media) are saved or deleted.
- Queue auto-purges for cron processing on high-traffic sites to stay under Cloudflare rate limits.
- Emit a `Cache-Tag` response header so Cloudflare can purge by tag reliably.
- Store Cloudflare credentials in `settings.php` so they never hit the database or config export.
- Store credentials in the Key module for secure, per-environment secret management.
- Use a scoped Bearer Token (Cache Purge permission only) instead of the all-powerful Global API Key.
- Run cache purges from CI/CD or cron via Drush (`drush cloudflare:purge-url`, `purge-tags`, etc.).
- Add a tag prefix to disambiguate multiple Drupal sites sharing one Cloudflare zone.
- Purge the whole zone automatically on every full Drupal cache flush (`drush cr`) — opt-in.
- Cap the `Cache-Tag` header size (and optionally hash tags) to avoid 5xx on tag-rich pages.
- Discard queued purge items older than a TTL when the queue can't keep up with edge expiry.
- Rate-limit purge requests per minute to protect a free-tier Cloudflare account.
- Review recent purge operations (success/failure) on the Purge History admin page.
- Delegate manual purging to editors via the `cloudflare purge` permission without giving them admin.
- Gate the destructive "Purge Everything" behind its own restricted permission and a confirm form.
- Check configuration status from the CLI with `drush cloudflare:status` before a deploy.
- Batch large purge lists automatically (100/request) so oversized inputs still fully purge.
- Serve as a lightweight alternative to the full Purge/Cloudflare module stack when you only need cache invalidation.
