# Health Check URL — manual setup guide

**Health Check URL** (`health_check_url`) exposes a lightweight, publicly
reachable endpoint — by default `/health` — that returns a short plain‑text
response so load balancers and uptime monitors can confirm your Drupal site is up
and serving traffic.

Because the response is rendered through Drupal (and served without caching), a
successful reply proves that PHP and Drupal actually booted, not just that a web
server answered. That makes it a good target for an **AWS/GCP/Azure load balancer
health check**, a **Kubernetes liveness or readiness probe**, or an uptime
monitor such as **Pingdom** or **UptimeRobot** that string‑matches the response
body.

You control what the endpoint returns and where it lives. The response can be a
plain **timestamp**, a fixed marker **string** (for example `Passed`, or a
per‑environment value like `prod-ok`), or a combination of the string with a
timestamp or a formatted date and time. You can also move the endpoint off the
default `/health` path to something less guessable, and decide whether it keeps
responding while the site is in maintenance mode.

Health Check URL has no dependencies beyond Drupal core and adds no fields,
entities, or Drush commands. It provides one settings form and a dedicated
permission for administering it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   response type, marker string, endpoint path, and maintenance‑mode access.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Health
Check URL settings** (`/admin/config/development/health`), gated by the **Health
Check URL administration** permission. The health endpoint itself lives at
`/health` (or whatever path you configure).

## How to use it

Enable the module, visit the settings form to pick the response type and, if you
want, a custom marker string and endpoint path, and save. Then point your load
balancer or monitor at the endpoint URL. See
[Configuration](configuration/index.md) for the details of each setting.
