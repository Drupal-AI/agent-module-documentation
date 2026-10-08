Akamai integrates Drupal cache invalidation with the Akamai CDN's Content Control Utility (CCU / Fast Purge) API, so that pages and cache tags are purged from Akamai's edge servers when content changes.

---

The module wraps the `akamai-open/edgegrid-client` PHP library to talk to Akamai's CCUv3 (Fast Purge) REST API. Credentials (client token, client secret, access token, REST API host) are stored either in an `.edgerc` file on the server or, preferably, through the Key module — chosen via the `storage_method` setting. It exposes a versioned client plugin type (`@AkamaiClient`, id `v3` = `AkamaiClientV3`) resolved through `AkamaiClientFactory`. Most sites drive it through the Purge module: the module ships two Purge purger plugins — `akamai` (URL/full-path purger) and `akamai_tag` (cache-tag purger) — plus Purge diagnostic checks for credentials and queue length. Without Purge, editors can clear URLs manually at `/admin/config/akamai/cache-clear` (form) or via a "Akamai Cache Clear" block on the current page. A CacheableResponseSubscriber can emit an `Edge-Cache-Tag` response header (with an optional blacklist) so Akamai indexes Drupal cache tags for tag-based purging. Purges can target the `production` or `staging` Akamai network, support `delete` vs `invalidate` actions (CCUv3), and can be globally killswitched via the `disabled` flag. An Edgescape helper and token (`[akamai:edgescape:*]`) expose Akamai's geolocation headers to Drupal. All settings live in the `akamai.settings` config object edited at `/admin/config/akamai/config`.

---

- Automatically purge Akamai edge caches when Drupal content is updated, via the Purge queue and the `akamai` purger.
- Purge by cache tag through the `akamai_tag` purger so only affected pages are invalidated on the CDN.
- Send an `Edge-Cache-Tag` response header exposing Drupal cache tags to Akamai for surrogate-key purging.
- Manually clear a list of URLs from Akamai at `/admin/config/akamai/cache-clear` without deploying code.
- Add the "Akamai Cache Clear" block so an editor can flush the page they are currently viewing.
- Store Akamai API credentials securely with the Key module instead of a plaintext `.edgerc` file.
- Reference an existing `.edgerc` file (with a named section) for credentials on servers that already have one.
- Choose between the Akamai `production` and `staging` networks for cache-clearing operations.
- Switch the CCUv3 action between `delete` (evict from edge) and `invalidate` (mark stale, revalidate on next request).
- Globally disable all outgoing Akamai calls with a killswitch while debugging or during maintenance.
- Log every request and response to the `akamai` logger channel for troubleshooting purge failures.
- Blacklist noisy cache-tag prefixes so they are stripped from the `Edge-Cache-Tag` header.
- Set the site base path (FQDN) so relative URLs are expanded to fully-qualified URLs Akamai can index.
- Send the base path as the Fast Purge `hostname` request member when purging URLs on multi-host setups.
- Tune the API request timeout for slow networks.
- Restrict who can configure Akamai (`administer akamai`) versus who can trigger manual purges (`purge akamai cache`).
- Expose Akamai Edgescape geolocation (continent, country_code, …) to Drupal via the `[akamai:edgescape:*]` token.
- Run Purge diagnostic checks that warn when Akamai credentials are missing or the purge queue is too long.
- Integrate a headless/decoupled front end's CDN invalidation by queuing URL purges through `purge_queuer_url`.
- Provide a programmatic Akamai client (`akamai.client.factory`) for custom modules that need to purge on demand.
- Support multiple CCU client versions through the `akamai_client` plugin type without changing calling code.
- Separate staging-network validation of purge behavior from production to test invalidation safely.
- Clear specific asset URLs (images, PDFs) after re-uploading a file with the same path.
