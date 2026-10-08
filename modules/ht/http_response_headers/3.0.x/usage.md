<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Response Headers lets you add, change, or remove arbitrary HTTP response headers through the admin UI, with a focus on security headers (X-Frame-Options, CSP, HSTS, Referrer-Policy, …) and performance/cache headers — each stored as a config entity and optionally scoped by visibility conditions.

---

Each header is a `response_header` config entity with an `id`, `label`, `description`, a `name` (the actual HTTP header, e.g. `X-Frame-Options`), a `value`, a `status` (enabled flag), and a `visibility` map of core condition plugins. A response event subscriber (`AddHTTPHeaders`, on `KernelEvents::RESPONSE` at priority `-100`) loops over every enabled header entity, evaluates its visibility conditions (all must pass, AND logic), and then **sets the header to the configured value — or, if the value is empty, removes that header from the response**. This makes it equally good at adding a header (`Strict-Transport-Security: max-age=…`) and at stripping one Drupal or PHP emits (`X-Powered-By`, `X-Generator`). Headers are managed at `/admin/config/system/response-headers` (list builder with enable/disable/edit/delete, add form, permission `administer http response headers` plus finer add/edit/delete permissions). The module ships ten ready-made header configurations as optional config (Access-Control-Allow-Origin, Content-Security-Policy, Public-Key-Pins, Referrer-Policy, Strict-Transport-Security, X-Content-Type-Options, X-Frame-Options, X-Generator, X-Powered-By, X-Xss-Protection) that you can enable and tune. No Drush commands are provided; everything is config.

---

- Add `X-Frame-Options: DENY` to block your site from being framed (clickjacking protection).
- Send a `Content-Security-Policy` header to restrict script/style sources.
- Enable HSTS with `Strict-Transport-Security: max-age=31536000; includeSubDomains`.
- Set `Referrer-Policy: strict-origin-when-cross-origin` for privacy.
- Add `X-Content-Type-Options: nosniff` to stop MIME sniffing.
- Remove the `X-Powered-By` header to hide the PHP version (set an empty value).
- Remove or blank the `X-Generator` header so Drupal isn't advertised.
- Add `X-Robots-Tag: noindex` to keep a section out of search engines.
- Configure `Access-Control-Allow-Origin` for a specific CORS scenario.
- Add a `Permissions-Policy` header value manually as a config entity.
- Set cache-related headers (e.g. a custom `Cache-Control`) for performance.
- Scope a header to only certain pages/roles/languages via visibility conditions.
- Enable a header on the whole site but disable it on admin pages using a request-path condition.
- Add a custom application header (e.g. `X-App-Version`) for debugging/monitoring.
- Override a header that another layer sets, by configuring the same header name with a new value.
- Turn a shipped default header on or off from the admin list without code.
- Toggle a header per environment by enabling/disabling its config entity.
- Add `X-Xss-Protection: 1; mode=block` for legacy browsers.
- Standardize security headers across sites by exporting/importing the `response_header` config.
- Quickly disable a problematic header during debugging via the list builder's disable link.
- Add a `Cross-Origin-Opener-Policy` / `Cross-Origin-Embedder-Policy` header as needed.
- Strip a header injected by a contrib module by configuring an empty value for its name.
- Meet a pen-test/security-audit checklist of required response headers in one place.
- Apply a header only to a specific content type's pages using a node-type condition.
