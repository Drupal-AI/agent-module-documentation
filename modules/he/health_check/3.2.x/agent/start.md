# health_check — agent start

Registers one route, `health_check.content`, at `/health`. `HealthController::content()` returns
HTTP 200 with a UNIX timestamp (`time()`) as a `text/plain` body. The route sets `no_cache: TRUE`,
`_maintenance_access: TRUE`, `_access: 'TRUE'`, and `_disable_route_normalizer: 'TRUE'`. No config,
no settings form, no permissions, no plugins; depends only on Drupal core. Path `/health` is fixed.

- The `/health` endpoint, what it returns, and using it with a load balancer / uptime monitor → [configure/health_check.md](configure/health_check.md)
