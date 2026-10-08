<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Health Check URL exposes a lightweight, publicly accessible endpoint (default `/health`) that returns a plain-text health string, so load balancers and uptime monitors can confirm the Drupal site is up.

---

The module registers its endpoint dynamically: `health_check_url.routing.yml` uses a `route_callbacks` entry pointing at `RouteService::routes()`, which reads the `health_check_url.settings` config and builds a `Route` at `/<endpoint>` (endpoint trimmed of slashes; default `health`). That route is access-open (`_access: 'TRUE'`), `no_cache`, and its `_maintenance_access` follows the `maintainence_access` setting. `HealthCheckController::healthCheckUrl()` returns a `text/plain` `Response` whose body is chosen by the `type` setting from five formats: `timestamp` (unix time), `string` (the configured text), `stringWithTimestamp`, `stringWithDateTime`, and `stringWithDateTimestamp`. The settings form (route `health_check_url.admin` at `admin/config/development/health`, permission "health_check_url administration") lets you set the response type, the text string (default `Passed`), the endpoint path, and whether the endpoint responds during maintenance mode; on save it also calls `router.builder->rebuild()` so a changed path takes effect. Config keys live in `health_check_url.settings`: `type`, `string`, `endpoint`, `maintainence_access`. The module has no dependencies beyond core and no fields, entities, plugins, or Drush commands.

---

- Give a cloud load balancer (AWS ELB/ALB, GCP, Azure) a URL to poll for site health.
- Provide a Kubernetes liveness/readiness probe target at a stable path.
- Expose an uptime-monitor endpoint (Pingdom, UptimeRobot) returning a known string.
- Return a plain `Passed` string so a monitor can string-match the response body.
- Return a Unix `timestamp` so a monitor can confirm the response is fresh, not cached.
- Move the health endpoint off `/health` to a custom, less-guessable path.
- Keep the health endpoint responding while the site is in maintenance mode.
- Restrict the health endpoint to normal operation by disabling maintenance access.
- Serve a `string with timestamp` combo for both a marker word and freshness.
- Provide a date/time-formatted health response for human-readable status checks.
- Standardise a health path across many Drupal sites via exported `health_check_url.settings`.
- Add a cache-bypassing (`no_cache`) endpoint so checks always hit a live response.
- Verify PHP/Drupal bootstrap succeeds by hitting an endpoint that renders through Drupal.
- Configure a custom marker string per environment (e.g. `prod-ok`, `stage-ok`).
- Point a blue/green deployment switch at the health endpoint during cutover.
- Give NOC dashboards a simple text endpoint to scrape.
- Change the response format without code by editing the `type` setting.
- Protect the admin form behind the dedicated "health_check_url administration" permission.
- Confirm a container is serving traffic before adding it to a pool.
- Provide a canary endpoint that returns a string plus timestamp for log correlation.
