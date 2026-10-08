# The /health endpoint & load-balancer usage

## The endpoint

| Fact | Value |
|---|---|
| Route name | `health_check.content` |
| Path | `/health` (fixed — **not** configurable) |
| Controller | `\Drupal\health_check\Controller\HealthController::content` |
| Method/response | Returns a plain `Symfony\Component\HttpFoundation\Response` with body `time()` (a UNIX timestamp), status `200`, `Content-Type: text/plain` |

There is **no settings form and no configuration** (`configure` route is null; no `config/install`,
no `config/schema`, no permissions). Enable the module and `/health` works immediately.

## Route options (why it behaves the way it does)

From `health_check.routing.yml`:

| Option | Value | Effect |
|---|---|---|
| `requirements._access` | `'TRUE'` | Public — no permission or login needed to poll it. |
| `options.no_cache` | `TRUE` | Response is never cached; every request re-hits the live instance. |
| `options._maintenance_access` | `TRUE` | Answers even while the site is in maintenance mode. |
| `defaults._disable_route_normalizer` | `'TRUE'` | Skips URL/route normalization for this route. |

## What a 200 tells you

Drupal still routes and dispatches the request to produce the body, so a `200` with a fresh
timestamp means PHP and Drupal's request handling are alive on that instance. It does **not** run
a suite of subsystem checks — there are no pluggable checks in this module. If the instance cannot
bootstrap, the web server returns a 5xx (or the connection fails) instead of 200.

## Using it with a load balancer / uptime monitor

Point the health check at `GET /health` and treat HTTP `200` as healthy, anything else as unhealthy.

- **Load balancer** (HAProxy/NGINX/AWS ELB-ALB/F5): set the health-check path to `/health`; a
  non-200 drops the instance from rotation.
- **Kubernetes**: use `/health` as an HTTP `livenessProbe` / `readinessProbe` path.
- **Uptime monitor** (Pingdom/UptimeRobot/StatusCake): monitor `https://your-site/health` for 200.
- **Quick manual check**: `curl -i https://your-site/health` → expect `200` and a numeric timestamp body.

Because `no_cache` is set, frequent polling will not populate or poison Drupal's page cache, and the
timestamp changes on every request, confirming the response is live rather than a cached copy.

## Not available

No configurable path, no pluggable/custom checks, no services, no hooks (`*.api.php`), no Drush
commands. To check other paths or add custom logic you would need a separate module — `health_check`
itself only provides the fixed `/health` timestamp endpoint.
