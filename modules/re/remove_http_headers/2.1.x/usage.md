Remove HTTP Headers strips a configurable list of HTTP response headers (e.g. `X-Generator`, `X-Drupal-Dynamic-Cache`) from every main-request response, so the site discloses less about the software behind it.

---

The module registers an HTTP stack middleware (`RemoveHttpHeadersMiddleware`) with a high priority (`priority: 1000`, so it runs last, after the page cache middleware) that inspects each main request's outgoing response and calls `$response->headers->remove()` for every header name in the configured list. The list lives in a single config object, `remove_http_headers.settings`, under the `headers_to_remove` key — a simple sequence of header-name strings. By default it removes `X-Generator`, `X-Drupal-Dynamic-Cache`, and `X-Drupal-Cache`. A `ConfigManager` service reads and caches the list (cache id/tag `remove_http_headers.settings.headers_to_remove`) so the middleware avoids re-reading config on every request, invalidating the cache whenever the list is saved. Site builders edit the list as a textarea (one header per line) at **Admin → Configuration → System → Remove HTTP headers settings** (`/admin/config/system/remove-http-headers`), gated by the `remove_http_headers settings access` permission. As a special case, when `X-Generator` is in the list, `hook_page_attachments_alter()` also strips Drupal's default `<meta name="Generator">` tag from the HTML `<head>`, so the version fingerprint is removed from markup as well as headers. The module has no dependencies beyond Drupal core (^10.3 || ^11), defines no plugins, and adds no Drush commands.

---

- Hide the `X-Generator` header so responses no longer advertise "Drupal N".
- Remove the `<meta name="Generator">` tag from the HTML `<head>` (triggered by removing `X-Generator`).
- Strip `X-Drupal-Dynamic-Cache` from responses to hide cache-state internals.
- Strip `X-Drupal-Cache` (page cache HIT/MISS) so caching behavior isn't disclosed.
- Reduce software fingerprinting to make automated vulnerability scanning less targeted.
- Remove any custom or third-party header by adding its name to the list.
- Meet a security/pentest finding that flags "information disclosure via response headers".
- Remove `X-Powered-By` if a server or module adds it, by listing the header name.
- Configure the removal list through the admin UI textarea, one header per line.
- Set the list directly in `remove_http_headers.settings.yml` as a `headers_to_remove` sequence.
- Deploy the header list as configuration between environments via `drush config:export`/`import`.
- Set the list from the CLI with `drush config:set remove_http_headers.settings headers_to_remove ...`.
- Keep the default three headers or replace them entirely with your own list.
- Restrict who can change the removal list via the `remove_http_headers settings access` permission.
- Ensure removal runs after page cache middleware so cached responses are also cleaned (high middleware priority).
- Only strip headers on the main request, leaving subrequests untouched.
- Standardize header hygiene across a multisite by exporting one shared config object.
- Clear the module cache automatically when the header list is updated.
- Audit which headers a response exposes, then prune the sensitive ones.
- Combine with a security-headers module: this one removes, others add.
- Programmatically check whether a header is configured for removal via `ConfigManager::shouldHeaderBeRemoved()`.
- Read the effective list in code with `ConfigManager::getHeadersToRemove()`.
- Validate header names on save (the form rejects entries containing whitespace).
- Remove privacy-relevant headers to limit what caches and proxies learn about the stack.
