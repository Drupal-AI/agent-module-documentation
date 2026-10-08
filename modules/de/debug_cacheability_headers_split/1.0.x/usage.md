Debug Cacheability Headers Split splits oversized X-Drupal-Cache-Tags and X-Drupal-Cache-Contexts debug headers into multiple numbered headers so they stay under a server's per-header size limit.

---

When Drupal core's `http.response.debug_cacheability_headers` setting is enabled, core emits the `X-Drupal-Cache-Tags` and `X-Drupal-Cache-Contexts` response headers for cacheable responses. On complex sites the combined list of cache tags or contexts can be large enough that a single header exceeds the maximum per-header size a web server or proxy allows (commonly 8KB), which surfaces as errors such as a white screen of death or a 502 Bad Gateway. This module adds a response event subscriber (running after core's `FinishResponseSubscriber`, at priority -500) that measures each of those two headers and, when a header's length exceeds a configurable size limit, word-wraps the value into chunks and re-emits it across numbered headers (`X-Drupal-Cache-Tags`, `X-Drupal-Cache-Tags-1`, `X-Drupal-Cache-Tags-2`, and so on). Splitting happens on whitespace boundaries so individual cache-tag/context literals are never cut. Two thresholds are configurable — the size limit that triggers a split (default 8192 bytes, minimum 1024) and the maximum chunk size per split header (default 8000 bytes, minimum 512) — through a settings form at `/admin/config/development/settings/cacheability` (permission: administer site configuration) or via `settings.local.php`. The module does nothing unless core's debug cacheability headers are enabled and the response is a `CacheableResponseInterface`.

---

- Keep debug cacheability headers usable on complex pages whose cache-tag lists would otherwise exceed the server's per-header size cap.
- Avoid white-screen-of-death or 502 Bad Gateway errors caused by oversized `X-Drupal-Cache-Tags` headers in development environments.
- Debug cache tags on Apache2 with `mod_proxy_fcgi`, where the per-header limit may be fixed and not raisable.
- Inspect the full set of cache tags for a page across `X-Drupal-Cache-Tags`, `X-Drupal-Cache-Tags-1`, `X-Drupal-Cache-Tags-2`, etc.
- Inspect the full set of cache contexts across `X-Drupal-Cache-Contexts` and its numbered continuation headers.
- Lower the split threshold below a strict reverse-proxy header limit (e.g. set `header_size_limit` to 5120) so headers split earlier.
- Tune the per-chunk size (`header_chunk_size`) to keep each split header comfortably under an intermediary proxy's limit.
- Configure the thresholds per environment via `settings.local.php` without changing exported site configuration.
- Enable readable cacheability debugging in a Docker/DDEV/reverse-proxy stack that imposes a header size limit.
- Diagnose why a page is not caching by reading its full cache-tag list without hitting server header limits.
- Verify that a render array is bubbling the expected cache tags on a tag-heavy listing or dashboard page.
- Confirm cache-context variation (e.g. per-user, per-permissions) on pages with many contexts.
- Support performance audits that rely on cacheability metadata for pages that previously errored under debug headers.
- Let a CI or profiling run collect cacheability headers on large pages without server-level header failures.
- Provide a lightweight, dependency-free fix while waiting on a core-level resolution to the oversized-header issue.
- Enable cacheability debugging on a shared hosting or managed platform where the server header limit cannot be changed.
- Reassemble the split headers client-side (concatenate `X-Drupal-Cache-Tags` with its numbered parts) to reconstruct the original value.
- Turn the feature off simply by disabling core's `http.response.debug_cacheability_headers` — the module then takes no action.
- Restrict changes to the split thresholds to site administrators via the `administer site configuration` permission.
