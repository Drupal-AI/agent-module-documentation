# Configure Advanced CORS (the `route_config` entity)

Managed at **Configuration → Web services → CORS Settings** (`/admin/config/services/advanced_cors`,
route `entity.route_config.collection`). The entity's `admin_permission` is core
**`administer site configuration`**, so only trusted admins can add/edit/delete policies. Add/Edit forms:
`RouteConfigEntityForm`; delete: `RouteConfigEntityDeleteForm`.

Config entity type `route_config` (`config_prefix: route_config`, schema `advanced_cors.route_config.*`).

## Fields (all stored on the entity)

| Field | Header emitted | Notes |
|---|---|---|
| `label` | — | Human label. |
| `id` | — | Machine id. |
| `status` | — | Only enabled (`status = 1`) entities are considered. |
| `weight` | — | Lower weight sorts first; **first matching entity wins** (see below). |
| `patterns` | — | Newline-delimited path patterns (core `PathMatcher` syntax, `*` wildcards, internal paths). |
| `allowed_origins` | `Access-Control-Allow-Origin` | Newline-delimited origin list; see origin selection below. |
| `allowed_methods` | `Access-Control-Allow-Methods` | e.g. `GET, POST, OPTIONS`. |
| `allowed_headers` | `Access-Control-Allow-Headers` | e.g. `Content-Type, Authorization`. |
| `exposed_headers` | `Access-Control-Expose-Headers` | Headers the browser may read. |
| `max_age` | `Access-Control-Max-Age` | Preflight cache seconds (string). |
| `supports_credentials` | `Access-Control-Allow-Credentials` | Set to `true` to allow credentialed requests. |

Each non-`origin` header is emitted only when its configured value is non-empty
(`addCorsHeaders()` trims and skips empties, and always overwrites any existing header — `set(..., TRUE)`).
`patterns` and `allowed_origins` are split on newlines and trimmed (`splitAndFilterValue`).

## How a request is matched (`AdvancedCorsEventSubscriber::onResponse`)

1. Subscribes to `KernelEvents::RESPONSE`.
2. Takes the request path info and resolves it to the internal path via `path_alias.manager`
   (`getPathByAlias`).
3. Iterates the cached `{pattern => entity_id}` map (built by `PatternsCache` from enabled entities sorted
   by weight) and, on the **first** `PathMatcher::matchPath()` hit, loads that entity, applies its headers,
   and `break`s. So **only one policy applies per request** — order patterns by weight accordingly.

## Origin selection (`selectOrigin`) — not an open reflector

`Access-Control-Allow-Origin` is single-valued, so the module picks one:

- If the request `Origin` header **exactly equals** one of the entity's `allowed_origins`, that value is
  returned (echoed back).
- Otherwise it returns the **first** configured origin (a deliberate mismatch so the browser blocks the
  request and signals a misconfiguration).

It never reflects an arbitrary/unlisted Origin — the returned value always comes from the admin-configured
`allowed_origins` list.

## Caching

Enabled patterns are cached under `advanced_cors:patterns_cache` (`cache.default`). After changing entities
call `PatternsCache::resetCache()` (or a cache rebuild) to pick up changes.

## Configuration caveat (admin responsibility, not a module bug)

Values are written verbatim. An administrator can configure an insecure combination such as
`allowed_origins` = `*` **with** `supports_credentials: true` — the spec-violating "wildcard + credentials"
CORS misconfiguration that browsers reject and that, if a single explicit origin were used instead, would
permit credentialed cross-origin reads. There is no guard against this; configure `allowed_origins` to an
explicit trusted origin list and only enable `supports_credentials` when you intend credentialed CORS. (This
is a trusted-admin config choice behind `administer site configuration`, not an unauthenticated exposure.)
