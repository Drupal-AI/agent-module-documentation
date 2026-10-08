Advanced CORS lets you set CORS response headers (Access-Control-Allow-Origin, -Methods, -Headers, -Credentials, etc.) on a per-path-pattern basis, using config entities that match request paths — a finer-grained alternative to Drupal's single global `cors.config` in `services.yml`.

---

The module defines a `route_config` config entity (managed at *Configuration → Web services → CORS
Settings*, `/admin/config/services/advanced_cors`, guarded by the core `administer site configuration`
permission) where each entry holds a newline-delimited list of path **patterns**, a **weight**, and the CORS
values: `allowed_origins`, `allowed_methods`, `allowed_headers`, `exposed_headers`, `max_age`, and
`supports_credentials`. A response-event subscriber (`AdvancedCorsEventSubscriber` on
`KernelEvents::RESPONSE`) resolves the current request path to its internal path via the alias manager, then
walks the enabled entities (ordered by weight, cached by `PatternsCache`) and, on the **first** pattern that
matches (core `PathMatcher`), stamps the configured headers onto the response. For `Access-Control-Allow-Origin`
it does not blindly echo the request `Origin`: `selectOrigin()` returns the request Origin only if it is one
of the entity's configured `allowed_origins`, otherwise it returns the first configured origin (the browser
then rejects the mismatched request). Origins and patterns are newline-split and trimmed
(`splitAndFilterValue`). The pattern list is cached under `advanced_cors:patterns_cache` and rebuilt via
`PatternsCache::resetCache()`. Only one matching entity applies per request (first match by weight wins).
Values are written verbatim into headers, so an administrator is responsible for not configuring an unsafe
combination (e.g. `allowed_origins: *` together with `supports_credentials: true`).

---

- Apply different CORS policies to different URL paths on one site (e.g. `/api/*` vs the rest).
- Allow a specific front-end origin to call your JSON:API/REST endpoints under `/api/*`.
- Set `Access-Control-Allow-Methods` (GET, POST, PUT, DELETE…) for an API path subtree.
- Whitelist request headers via `Access-Control-Allow-Headers` for a decoupled front end.
- Expose custom response headers to the browser with `Access-Control-Expose-Headers`.
- Cache preflight results by setting `Access-Control-Max-Age` on a path.
- Enable credentialed cross-origin requests on a path with `Access-Control-Allow-Credentials`.
- Restrict allowed origins to an explicit list and echo back only a matching request Origin.
- Order overlapping path rules by weight so the most specific policy wins first.
- Match paths with wildcards (`/api/*`) using Drupal's PathMatcher against internal (aliased) paths.
- Provide CORS headers without editing `sites/*/services.yml` or redeploying code.
- Scope a permissive CORS policy to a single integration path rather than the whole site.
- Give a mobile app or SPA the exact CORS headers it needs on its endpoints.
- Add CORS headers to alias-based paths (the module resolves aliases to internal paths first).
- Manage multiple named CORS policies (enable/disable, weight, label) as exportable config entities.
- Migrate from the global core CORS config to path-scoped policies.
