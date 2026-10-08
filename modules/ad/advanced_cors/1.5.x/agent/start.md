# Advanced CORS — agent index

Sets CORS response headers **per path pattern** via `route_config` config entities, as a finer-grained
alternative to core's single global `cors.config`. Depends on `path_alias`. Config UI guarded by core
`administer site configuration`. No own permissions, no Drush, no plugin types. Config schema provided.

- **The `route_config` entity: every field, how patterns match, origin selection, caching, weight
  precedence, and the `*`+credentials caveat** → [configure/route-config.md](configure/route-config.md)

Key facts:
- Config entity `route_config` (`advanced_cors.route_config.*`), managed at
  `/admin/config/services/advanced_cors` (route `entity.route_config.collection`).
- `AdvancedCorsEventSubscriber` on `KernelEvents::RESPONSE` resolves the aliased→internal path and applies
  the **first** enabled entity (ordered by weight) whose pattern matches, then stamps the headers.
- `selectOrigin()` echoes the request `Origin` only if it is in the entity's `allowed_origins`; otherwise
  returns the first configured origin (it does NOT reflect arbitrary origins).
- Pattern list cached as `advanced_cors:patterns_cache`; rebuilt via `PatternsCache`.
