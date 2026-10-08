CDNetworks Purge is a Purge plugin that invalidates cached content on the CDNetworks CDN over its authenticated REST API.

---

CDNetworks Purge adds a CDNetworks purger and a cache-tag header exporter to Drupal's Purge framework, letting content changes on the site clear the matching objects on the CDNetworks CDN. It authenticates to the CDNetworks Content Management API with a username plus an API key (both stored as Key entities, not in plain config) and supports invalidating individual URLs, whole directories (wildcard paths ending in `/`), regular-expression URLs, and cache tags. Purger-driven invalidation runs through Purge's queue/processor pipeline; an admin form and a legacy Drush command are also provided for manual purges. Configuration (base URI, the accelerated CDN domain, the two Key references, batch limit, cache-tag toggle, verbose logging) lives in a single settings form under Performance.

---

- Automatically purge changed pages from the CDNetworks CDN as content is edited, via the Purge module's queuers and processors.
- Add the "CDNetworks Purger" as a purger in the Purge configuration (Configuration -> Development -> Performance -> Purge) to enable URL invalidation.
- Store the CDNetworks username and API key securely as Key entities (e.g. environment-variable keys) rather than in exported site config.
- Invalidate a single URL on the CDN (URLs not ending in `/` are treated as exact objects).
- Invalidate an entire directory/wildcard path by ending the URL in a `/`.
- Choose the CDN operation per purge: `default`, `delete` (remove the cached file directly), or `expire` (mark the cached file expired).
- Invalidate content by regular-expression URL patterns for bulk clearing.
- Invalidate by cache tag (e.g. `node_1`, `node_list`) so tag-based dependencies clear across many pages.
- Emit a `tag` response header on cacheable pages (with `:` rewritten to `_`) so the CDN can associate objects with Drupal cache tags — enable "Cache Tag headers" in settings.
- Combine with `purge_queuer_coretags` (bundled with Purge) to queue core cache tags for invalidation.
- Combine with `purge_queuer_url` if you want URL-based queueing instead of tag-based.
- Manually purge a batch of URLs, regex URLs, and tags from the admin form at `/admin/config/development/cdnetworks_purge/purge`.
- Rewrite the host of queued internal URLs to the configured accelerated CDN domain before sending them to the API.
- Tune how many items are sent per invalidation cycle with the "Ideal Conditions Limit" setting.
- Batch large URL purges automatically (the purger chunks invalidations into groups of 500 to respect the API limit).
- Turn on verbose logging to record successful purges and the URLs sent, for debugging CDN integration.
- Restrict who can change CDN credentials with the "Administer CDNetworks Purge Configuration" permission.
- Restrict who can run manual purges with the "CDNetworks Manual Purge" permission.
- Get a site status-report warning when the CDNetworks credentials/configuration are incomplete (via `hook_requirements`).
- Reuse the bundled `cdnetworks_purge.client` service in custom code to call `purgeUrl()`, `purgeRegex()`, or `purgeTag()` directly.
- Front a multi-domain site with CDNetworks and keep each environment's CDN cache in sync with Drupal content edits.
- Migrate an existing CDNetworks-fronted site to managed cache invalidation without hand-clearing the CDN dashboard.
