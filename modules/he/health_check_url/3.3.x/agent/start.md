<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Health Check URL — agent index

Exposes a public, cache-free plain-text health endpoint (default `/health`) for load
balancers and monitors. The path and response body are configurable. No dependencies
beyond core; no fields, entities, plugins, or Drush.

- **Settings keys, response types, endpoint path, permission, how the route is built** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object: `health_check_url.settings` → `type`, `string`, `endpoint`,
  `maintainence_access` (note the module's spelling).
- Endpoint route is built dynamically by `RouteService::routes()` via `route_callbacks`
  in `health_check_url.routing.yml`; changing `endpoint` needs a router rebuild.
- Response types: `timestamp`, `string`, `stringWithTimestamp`, `stringWithDateTime`,
  `stringWithDateTimestamp` (controller `HealthCheckController::healthCheckUrl()`).
- Admin form: route `health_check_url.admin` at `admin/config/development/health`,
  permission `health_check_url administration`.
- Defaults: `type: timestamp`, `string: Passed`, `endpoint: /health`,
  `maintainence_access: false`.
