Health Check exposes a lightweight `/health` endpoint that returns HTTP 200 with a UNIX timestamp body, so load balancers and uptime monitors can tell whether a Drupal instance is serving requests.

---

The module registers a single route, `health_check.content`, at the path `/health`. It is handled by `HealthController::content()`, which returns a plain `Symfony\Component\HttpFoundation\Response` containing the current `time()` (a UNIX timestamp) as a `text/plain` body with status code 200. The route is configured to bypass Drupal's normal page machinery: it sets `no_cache: TRUE` (the response is never cached, so every request re-hits the instance), `_maintenance_access: TRUE` (it answers even while the site is in maintenance mode), `_access: 'TRUE'` (it is public, no permission required), and `_disable_route_normalizer: 'TRUE'`. Because Drupal still has to route and dispatch the request to return the body, a 200 with a fresh timestamp confirms PHP and Drupal's request handling are alive; if the instance cannot bootstrap, the web server returns a 5xx instead and the load balancer can drop that instance from rotation. The module has no configuration, no settings form, no permissions, no plugins, and no dependencies beyond Drupal core (`^9.4 || ^10 || ^11 || ^12`) and PHP `^8.0`. The endpoint path `/health` is fixed and not configurable.

---

- Give a load balancer (HAProxy, NGINX, AWS ELB/ALB, F5) a URL to poll for backend health.
- Configure a Kubernetes liveness or readiness probe to hit `/health`.
- Point an external uptime monitor (Pingdom, UptimeRobot, StatusCake) at `/health`.
- Let a reverse proxy drop an unhealthy Drupal instance from rotation automatically.
- Verify a newly deployed instance is serving before adding it to the pool.
- Confirm the site answers even during maintenance mode (the endpoint stays up).
- Get an always-fresh, never-cached response to detect a hung PHP-FPM worker.
- Use the returned UNIX timestamp to confirm the response is live (not a cached copy).
- Health-check a specific instance behind a load balancer without a full page render.
- Detect a failed bootstrap: a 5xx instead of 200 signals the instance is broken.
- Provide a cheap endpoint that avoids expensive full-page rendering on every poll.
- Run a smoke test in CI/CD that curls `/health` after deploy.
- Trigger auto-scaling or auto-healing based on the 200/non-200 result.
- Monitor each node of a multi-server cluster independently.
- Keep the check public (no auth) so infrastructure can poll it without credentials.
- Alert on-call when the endpoint stops returning 200.
- Distinguish "web server up but Drupal down" from "Drupal up" via the 200 body.
- Add the endpoint to a status dashboard aggregating many sites.
- Use as a blue/green deployment gate before switching traffic.
- Confirm database/bootstrap layers are reachable enough to route a request.
- Replace a heavier custom status page with a minimal, dependency-free check.
- Poll frequently without cache-poisoning or filling the render cache.
- Ensure the check answers on admin/maintenance windows so monitors don't false-alarm.
- Curl `/health` from a cron/watchdog script and act on the HTTP status.
