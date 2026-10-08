<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generic HTTP Purger adds configurable Purge "purgers" that clear an external cache (Varnish, an nginx proxy, a CDN, etc.) by firing HTTP requests — one request per invalidation (`http`) or one bundled request for a whole set (`httpbundled`) — with every part of the request (method, scheme, host, port, path, headers, body) fully configurable and token-aware.

---

The module plugs into the Purge framework by providing two purger plugins, `http` (`HttpPurger`, sends a separate request for each invalidation instruction) and `httpbundled` (`HttpBundledPurger`, sends one request for a batch), both `multi_instance` so you can configure several. Each configured instance stores its settings in a `httppurgersettings` config entity (`purge_purger_http.settings.<instance_id>`) covering the request line (`scheme`, `hostname`, `port`, `path`, `request_method` — default `BAN`), TLS `verify`, arbitrary outbound `headers`, an optional request `body` + `body_content_type`, the `invalidationtype` it handles (default `tag`), and performance knobs (`timeout`, `connect_timeout`, `cooldown_time`, `max_requests`, `runtime_measurement`, `http_errors`). The purger builds each request URL as `scheme://hostname:port/path` and runs the value through Purge's token service, so `path`, `headers`, and `body` can contain tokens such as `[invalidation:expression]` (for `http`) or `[invalidations:…]` (for `httpbundled`) that expand to the tag/path/URL being cleared. A `httpconfiguration` diagnostic check verifies that each enabled HTTP purger has its mandatory fields set and warns on mismatched scheme/port (https must use 443). It has no admin route of its own — you add and edit instances through Purge's purgers UI (Configuration › Development › Performance › Purge) — and no permissions or Drush commands. The bundled submodule **Generic HTTP Tags Header** exports a `Purge-Cache-Tags` response header so a proxy can do tag-based invalidation.

---

- Invalidate Varnish by cache tag with a `BAN` request whose `X-Cache-Tags` (or path regex) header carries `[invalidation:expression]`.
- Send a `PURGE` request to an nginx proxy for each changed URL.
- Configure a purger that clears a CDN edge cache over HTTPS for tag-based invalidation.
- Use the bundled purger (`httpbundled`) to clear many tags in a single request and cut request volume.
- Use the per-item purger (`http`) when the upstream expects one URL/tag per request.
- Set a custom `request_method` (BAN, PURGE, DELETE, GET, POST, …) to match the proxy's API.
- Point invalidations at a specific `hostname`/`port` (e.g. a Varnish admin listener on 6081).
- Template the request `path` with a token so each invalidation hits a different URL.
- Add authentication headers (e.g. an API key) to every purge request via the headers list.
- Send a JSON `body` with `body_content_type: application/json` to a CDN's purge API.
- Choose which invalidation type a purger handles (`tag`, `path`, `url`, `wildcardpath`, `everything`, …) via `invalidationtype`.
- Run multiple HTTP purgers at once (multi-instance) — e.g. one for Varnish and one for a CDN.
- Tune `timeout` / `connect_timeout` for a slow or remote proxy.
- Disable runtime measurement and rely on the timeout-based capacity estimate instead.
- Cap `max_requests` per Drupal run so a CLI purge can't hammer the proxy indefinitely.
- Add a `cooldown_time` so freshly-invalidated content propagates before the next purge.
- Treat 4xx/5xx responses as failures (`http_errors: true`) so failed purges are retried.
- Turn TLS certificate verification off (`verify: false`) for a self-signed staging proxy.
- Diagnose misconfiguration through the `httpconfiguration` check on Purge's status page.
- Enable the tags-header submodule to emit `Purge-Cache-Tags` for a tag-aware reverse proxy.
- Build a fully custom purge integration for an in-house caching layer without writing code.
- Clear a caching layer that only accepts requests on a private IP by setting hostname to that IP.
- Export the purger configuration to code and deploy the same cache-invalidation setup across environments.
- Combine with Purge's queue and processors so invalidations are drained in the background.
- Replace a hardcoded custom purge module with a configurable, token-driven HTTP purger.
