# Configuration

Health Check has **no settings form and nothing to configure inside Drupal** —
there's no config route, no config schema, and no permissions. The path `/health`
is fixed and can't be changed. So "configuration" here really means wiring the
endpoint into your infrastructure, which happens *outside* Drupal in your load
balancer, orchestrator, or monitoring tool.

## What the endpoint returns

`GET /health` returns:

- **Status:** `200`
- **Content‑Type:** `text/plain`
- **Body:** the current UNIX timestamp (a number like `1723600000`)

The timestamp changes on every request because the response is never cached, so a
fresh number confirms you're seeing a live reply rather than a cached copy.

## Why it behaves the way it does

A few route options make the endpoint suitable for infrastructure polling:

- **Public** — no permission or login is required, so your load balancer can poll
  it without credentials.
- **Never cached** — every request re‑hits the live instance, so frequent polling
  won't populate or poison Drupal's page cache, and you'll catch a hung worker.
- **Answers during maintenance mode** — the endpoint stays up while the site is in
  maintenance, so monitors don't false‑alarm during admin windows.

## What a 200 tells you (and what it doesn't)

Drupal has to route and dispatch the request to produce the body, so a `200` with
a fresh timestamp means PHP and Drupal's request handling are alive on that
instance. It does **not** run a suite of subsystem checks — there are no pluggable
checks in this module. If the instance can't bootstrap, the web server returns a
5xx (or the connection fails) instead of 200, which is exactly what your load
balancer needs to see.

## Wiring it into your infrastructure

Point the health check at `GET /health` and treat `200` as healthy, anything else
as unhealthy.

- **Load balancers** (HAProxy, NGINX, AWS ELB/ALB, F5): set the health‑check path
  to `/health`. A non‑200 drops the instance from rotation.
- **Kubernetes**: use `/health` as the HTTP path for a `livenessProbe` and/or
  `readinessProbe`.
- **Uptime monitors** (Pingdom, UptimeRobot, StatusCake): monitor
  `https://your-site/health` for a 200 response.
- **CI/CD and deployment gates**: `curl` `/health` after a deploy and only add the
  instance to the pool once it returns 200 (handy for blue/green rollouts).

## If you need more

There's no configurable path and no way to add custom subsystem checks in this
module — it's intentionally minimal. To check other paths or add richer logic
you'd use a separate module; Health Check itself only provides the fixed
`/health` timestamp endpoint.
