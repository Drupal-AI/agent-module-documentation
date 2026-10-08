<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imperva Cache Purger is a Purge-module purger plugin that clears the Imperva (Incapsula) CDN/WAF edge cache over Imperva's REST API whenever Drupal invalidates content.

---

Sites that run behind the Imperva cloud (a reverse proxy / CDN / WAF in front of Drupal) need the edge cache flushed when content changes, or visitors keep seeing stale pages. This module plugs a single purger into the Purge pipeline: it collects the path, wildcard-path, "everything" and cache-tag invalidations that Purge queues, and issues authenticated `DELETE` requests to Imperva's Cloud Application Security API (`https://my.imperva.com/api/prov/v2/sites/{site_id}/cache`) to drop the matching edge objects. You configure it from Purge's own admin screen at `/admin/config/development/performance/purge` by expanding the Imperva purger and clicking Configure: set the Imperva API ID, API key, site id, and choose whether to invalidate by path, by cache tag, or by both. A response subscriber additionally sends a `Cache-Tag` header on cacheable responses so Imperva can key its edge cache by Drupal cache tags. It is intentionally a very small module — one purger plugin, one invalidator service, one config form, one event subscriber — and leans on the Purge module for queueing, processing and testing.

---

- Purge the Imperva/Incapsula edge cache when Drupal content changes.
- Run Imperva as a reverse proxy/CDN in front of a Drupal site and keep the edge fresh.
- Add an Imperva purger to an existing Purge queue/processor setup.
- Invalidate specific URL paths on the Imperva edge after a node is edited.
- Invalidate by Drupal cache tag so related pages clear together.
- Invalidate everything (`^/`) on the edge after a large content or deployment change.
- Support wildcard-path invalidations for section-wide clears.
- Emit a `Cache-Tag` response header so Imperva can group edge objects by cache tag.
- Configure Imperva API credentials (API ID and API key) from the Purge admin UI.
- Point the module at a specific Imperva site by its numeric site id.
- Override the Imperva API endpoint to target a different API version.
- Temporarily disable edge purging (accept invalidations as succeeded without calling Imperva) in staging environments.
- Choose an invalidation strategy: by path only, by cache tag only, or by path and cache tag.
- Let Purge's cron/queue processors dispatch invalidations to Imperva in the background.
- Test edge purging using Purge's built-in diagnostics and processors.
- Log successful and failed invalidations to Drupal's logger for auditing.
- Integrate CDN cache clearing into an automated content-publishing workflow.
- Reduce stale-content windows for editors working behind Imperva.
- Pair with Purge's tags queuer to automatically enqueue tag invalidations on entity changes.
- Combine path and tag invalidation for sites that mix static routes and dynamic content.
- Provide edge-cache invalidation for multisite setups where each site has its own Imperva site id.
