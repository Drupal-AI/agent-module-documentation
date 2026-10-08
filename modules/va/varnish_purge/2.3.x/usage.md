Varnish Purger plugs into the Purge module to invalidate pages held in Varnish reverse-proxy caches, sending BAN/PURGE (and URIBAN) HTTP requests to your Varnish servers whenever Drupal content changes. Its machine name is `varnish_purger` even though the Drupal.org project is `varnish_purge`.

---

Varnish Purger is a set of Purge "purger" plugins for clearing content from Varnish. It ships three purger plugins: `varnish` (an HTTP purger that fires one HTTP request per invalidation, concurrency 10), `varnishbundled` (bundles a whole batch of invalidations into a single HTTP request), and `varnish_zeroconfig_purger` (a minimal-config purger that reads Varnish server IPs from Drupal's `reverse_proxy_addresses` setting and works with the bundled `zeroconfig.vcl`). The `varnish` and `varnishbundled` purgers are fully configurable per instance through Purge's UI: you set hostname, port, path, scheme, request method (`BAN` or `PURGE`), outbound headers (with Purge token replacement, e.g. `Cache-Tags: [invalidation:expression]`), timeouts, cooldown time, max requests and 4xx/5xx handling — all stored in a `varnishpurgersettings` config entity. Each configurable purger clears exactly one invalidation type, chosen per instance (tag, url, wildcardurl, everything, …), while the zero-config purger handles `url`, `wildcardurl`, `tag` and `everything` at once. A `varnishconfiguration` DiagnosticCheck stops half-configured purgers from loading and warns about http/https vs port mismatches. It depends on `purge` and `purge_tokens`, and the module itself has no admin page — purgers are added and configured through Purge's own UI (`purge_ui`) or Drush. Three submodules extend it: `varnish_purge_tags` (adds the `Cache-Tags` response header for tag-based invalidation), `varnish_image_purge` and `varnish_focal_point_purge` (issue `URIBAN` requests to flush image-style derivatives when entities/focal points change).

---

- Invalidate Varnish page cache automatically when nodes, blocks or menus change, via Purge's cache-tags queuer.
- Add a configurable Varnish purger with `drush p:purger-add varnish` and point it at your Varnish host/port.
- Send one HTTP request per invalidation with the `varnish` purger for fine-grained clearing.
- Bundle many invalidations into a single HTTP request with the `varnishbundled` purger to cut request volume.
- Run a low-config setup with the `varnish_zeroconfig_purger`, reading Varnish IPs from `$settings['reverse_proxy_addresses']`.
- Deploy the shipped `zeroconfig.vcl` as a starting Varnish 4 policy that understands `PURGE`, `BAN` and wildcard bans.
- Clear content by Drupal cache tag by sending a `BAN` request with a `Cache-Tags: [invalidation:expression]` header.
- Purge a single URL from Varnish with a `PURGE` request to a specific path.
- Ban wildcard URLs (e.g. everything under a path) through the zero-config purger's `wildcardurl` support.
- Flush the entire Varnish cache with an `everything` invalidation.
- Choose the invalidation type each configurable purger handles (tag, url, wildcardurl, everything) from a dropdown.
- Insert Purge tokens into the request path and header values so URLs/tags are computed per invalidation.
- Switch a purger between `BAN` and `PURGE` request methods to match your VCL.
- Send custom outbound HTTP headers (e.g. authentication tokens) with every purge request.
- Tune purge performance: connect/overall timeouts, cooldown time and max requests per request lifetime.
- Enable runtime capacity measurement so Purge auto-adjusts throughput based on measured request times.
- Disable SSL certificate verification for purgers talking to Varnish over self-signed https.
- Treat (or ignore) 4xx/5xx responses as failed invalidations via the "success resolution" setting.
- Run several Varnish purger instances at once (multi-instance) to clear multiple caches/data centres.
- Verify configuration health with Purge diagnostics — the `varnishconfiguration` check flags unconfigured purgers and scheme/port mismatches.
- Emit a `Cache-Tags` response header on cacheable pages by enabling the `varnish_purge_tags` submodule.
- Purge every image-style derivative of an entity's image fields on save with the `varnish_image_purge` submodule.
- Flush image derivatives when a Focal Point crop entity changes with the `varnish_focal_point_purge` submodule.
- Point purge requests at a specific `URIBAN` VCL handler for image invalidation without banning whole pages.
- Combine with Purge processors (cron, late-runtime) to run queued Varnish invalidations in the background.
- Migrate a site from full cache flushes to accurate tag-based Varnish invalidation.
