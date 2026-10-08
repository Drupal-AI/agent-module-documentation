Redirect metrics records how often each redirect (from the contrib `redirect` module) is actually used and when it was last hit, then surfaces "Popular redirects" and "Stale redirects" reports.

---

The module adds two base fields to the `redirect` entity — `access_count` (integer, initial value 0) and `last_access` (timestamp) — via `hook_entity_base_field_info()`, so no separate storage table is needed. A response-event subscriber (`redirect_metrics.request_subscriber`, priority on `KernelEvents::RESPONSE`) reads the `X_REDIRECT_ID` header that the `redirect` module sets on its redirect responses, loads that redirect, increments `access_count`, stamps `last_access` with the request time, and saves the entity. Because saving invalidates the redirect's cache tags before the page-cache entry is written, anonymous traffic still serves cached responses. On top of the data it ships a single View (`redirect_metrics`) with two page displays: **Popular redirects** at `admin/config/search/redirect/popular` (sorted by `access_count` descending) and **Stale redirects** at `admin/config/search/redirect/stale` (filtered to `last_access` older than 6 months). Three local tasks are added under the core redirect list (`redirect.list`): "All redirects", "Popular redirects", and "Stale redirects". The module defines no permissions, config form, drush commands, or plugins of its own — access to the reports is governed by the redirect module's own "administer redirects" permission, and the fields are plain entity base fields you can read or query directly.

---

- Find the most-used redirects on a site to understand which legacy URLs still receive traffic.
- Identify stale, never-hit redirects that are safe to delete after a content migration.
- Show a "Popular redirects" report at `admin/config/search/redirect/popular` sorted by hit count.
- Show a "Stale redirects" report at `admin/config/search/redirect/stale` for redirects unused in 6+ months.
- Track the last access timestamp of each redirect to audit when an old path was last requested.
- Count total hits per redirect without enabling full Drupal statistics or external analytics.
- Prioritise which 301s to convert into permanent content moves based on real usage.
- Report on redirect usage inside a custom View by adding the `access_count` and `last_access` fields.
- Sort or filter any redirect View by popularity or recency using the new base fields.
- Query `access_count` programmatically via an entity query to build custom dashboards.
- Detect redirect loops or hot paths by watching which redirect entities increment fastest.
- Clean up a bloated redirect table by deleting entries whose `access_count` is still 0.
- Measure the impact of a URL-structure change by watching hit counts on the new redirects.
- Provide editors a read-only view of which of their redirects actually get used.
- Feed redirect hit data into reporting because the values live on the entity, not a log table.
- Justify keeping or removing a redirect using its `last_access` age.
- Audit downloadable-file redirects (e.g. `/downloads/x` → asset) by their download count.
- Combine with Views bulk operations to delete all stale redirects in one action.
- Confirm a redirect is live by checking that its `access_count` increases after a test request.
- Give SEO teams a view of which redirected URLs still attract inbound links/traffic.
- Order a redirect export by usage so the busiest rules are reviewed first.
- Keep hit counting cheap and cache-friendly (no per-request cache-busting for anonymous users).
- Retain usage history across deployments because metrics are stored on the redirect entity itself.
- Spot redirects that suddenly stop being hit (last_access stops advancing) after a site change.
