# Health Check for Load Balancers — manual setup guide

**Health Check for Load Balancers** (`health_check`) exposes a lightweight
`/health` endpoint that returns **HTTP 200** with a UNIX timestamp in the body,
so load balancers, Kubernetes probes, and uptime monitors can tell whether a
Drupal instance is actually serving requests.

It does one thing and does it cheaply. The module registers a single route at
`/health`, handled by a controller that returns the current time as a plain‑text
body with status 200. The route is deliberately wired to bypass Drupal's normal
page machinery: the response is **never cached** (every request re‑hits the live
instance), it **answers even during maintenance mode**, and it's **public** — no
login or permission needed. Because Drupal still has to route and dispatch the
request to produce that body, a 200 with a fresh timestamp confirms that PHP and
Drupal's request handling are alive on that instance. If the instance can't
bootstrap, the web server returns a 5xx instead, and your load balancer can drop
it from rotation.

There is **no settings form, no permissions, no plugins, and no dependencies**
beyond Drupal core and PHP 8. The path `/health` is fixed and not configurable.
Enable the module and the endpoint works immediately — the only real "setup" is
pointing your infrastructure at it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — there's no settings form; this page
   explains the endpoint and how to wire it into load balancers, Kubernetes, and
   uptime monitors.

## Where it lives in the admin menu

Nowhere — Health Check has no admin page. Once enabled, it simply answers at
`https://your-site/health`.

## How to use it

Enable the module, then point any health check at `GET /health` and treat HTTP
**200** as healthy and anything else as unhealthy. A quick manual test:

```bash
curl -i https://your-site/health
```

You should get a `200` response and a numeric UNIX timestamp as the body. See
[Configuration](configuration/index.md) for wiring it into specific
infrastructure.
