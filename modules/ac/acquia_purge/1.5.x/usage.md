Acquia Purge provides turnkey, accurate cache invalidation for sites hosted on Acquia Cloud by plugging into the Purge module as a Purger, clearing Varnish load balancers and the Acquia Platform CDN when content changes.

---

Acquia Purge is a Purge "purger" plugin (plus supporting TagsHeader and DiagnosticCheck plugins) that lets the Purge pipeline wipe stale content from Acquia Cloud's Varnish load balancers and, optionally, the Acquia Platform CDN. It ships two purger plugins: `acquia_purge` ("Acquia Cloud") which supports `url`, `wildcardurl`, `tag` and `everything` invalidations, and `acquia_platform_cdn` ("Acquia Platform CDN") for `url`, `tag` and `everything`. On each cacheable response it injects an `X-Acquia-Purge-Tags` header so Varnish knows which cache tags a page carries; when tags are invalidated it fires concurrent `BAN`/`PURGE` HTTP requests (up to 6 at a time, tags grouped in batches of 15) directly to the load-balancer IPs discovered from Drupal's `reverse_proxies` setting. The module auto-detects the Acquia environment via `ah_site_info_keyed()` (or ACSF globals) through its `acquia_purge.platforminfo` service, so it is zero-config by design and deliberately exposes no admin UI or config forms. It depends on `purge` and `purge_queuer_coretags`, and is set up entirely with Drush by adding the purgers to Purge's configuration. Because balancers on Acquia Cloud host multiple sites, an "everything" purge only clears the current site instance via its unique site identifier. A small submodule, `acquia_purge_geoip`, adds `X-Geo-Country` to the `Vary` header for geo-varied caching.

---

- Invalidate Varnish cache on Acquia Cloud automatically when a node, block or menu changes (via Purge's core-tags queuer).
- Set up the "Acquia Cloud" purger on a Purge-enabled site with `drush p:purger-add --if-not-exists acquia_purge`.
- Add the "Acquia Platform CDN" purger with `drush p:purger-add --if-not-exists acquia_platform_cdn` to also clear the CDN.
- Purge a single URL from the Acquia load balancers via a Purge `url` invalidation.
- Purge wildcard URLs (e.g. everything under a path) via a `wildcardurl` invalidation.
- Clear content by Drupal cache tag so only affected pages are evicted, not the whole cache.
- Flush the entire current site instance with an `everything` invalidation without affecting sibling multisites.
- Emit the `X-Acquia-Purge-Tags` header on cacheable responses so Varnish can BAN by tag.
- Verify a working setup with `drush p:diagnostics` (Acquia Cloud, Platform CDN, Recommendations checks).
- Run tag purges in the background with Purge's late-runtime or cron processors.
- Harden purge requests against DDOS by setting a custom `X-Acquia-Purge` token via `$settings['acquia_purge_token']`.
- Detect load-balancer IPs automatically from the `reverse_proxies` setting in `settings.php`.
- Confirm the site is really on Acquia Cloud through the `acquia_purge.platforminfo` service before purging.
- Debug outgoing purge requests using Purge's debug mode and the module's Guzzle middleware.
- Group large tag sets into batches (15 tags/request) to avoid oversized Varnish headers.
- Scale invalidation throughput by sending up to 6 concurrent HTTP requests to the balancers.
- Vary cached pages by visitor country by enabling the `acquia_purge_geoip` submodule (adds `X-Geo-Country` to `Vary`).
- Support Acquia Platform CDN backends such as Fastly via the pluggable `AcquiaPlatformCdn` backend factory.
- Keep all purge configuration traceable in `settings.php` rather than a UI, for auditable site administration.
- Read platform facts (site name, group, environment, identifier) programmatically from `PlatformInfoInterface`.
- Move the Platform CDN purger up the Purge execution order with `drush p:purger-mvu`.
- Combine with Purge's core-tags queuer so cache-tag invalidations are queued the moment content is saved.
- Migrate an existing Acquia site to accurate tag-based invalidation instead of full cache flushes.
- Serve fresh content immediately after editorial changes on high-traffic Acquia Cloud sites.
- Avoid unsigned-certificate breakage by purging balancer IPs over plain HTTP with SSL verification disabled.
