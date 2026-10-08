# Redis — manual setup guide

**Redis** (`redis`) gives Drupal a fast, in-memory **cache backend** — and,
optionally, Redis-backed **lock**, **flood-control** and **queue** backends —
by connecting your site to a running [Redis](https://redis.io/) key-value server.
Instead of storing cache data in the SQL database, Drupal keeps hot data in Redis,
which is dramatically faster to read and write. This offloads the database on
high-traffic sites and lets several web servers behind a load balancer share one
cache.

The module itself is a lightweight placeholder: it exposes almost no admin UI.
Nearly everything is configured in **`settings.php`** (plus a shipped services
YAML file), not through a form on the site. The one screen it does add is a
read-only **status report** at **Reports → Redis** that tells you whether Drupal
is actually talking to your Redis server.

This guide is written for a **human** setting the module up by hand. It walks you
through installing the module, standing up a Redis server and PHP client, and
wiring the connection into `settings.php`. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Redis status report at Reports → Redis, showing the connection state](images/report.png)

## Where it lives in the admin menu

Redis has **no configuration form**. The only page it adds is the status report:

- **Reports → Redis** (`/admin/reports/redis`) — a read-only page that reports
  whether a Redis client is connected, and (when connected) client and server
  details. Viewing it requires the *Access Redis Report* permission.

Everything else — which server to connect to, which client to use, and which of
Drupal's subsystems to route through Redis — is set in code, in `settings.php`.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, plus the Redis server and PHP client it depends on.
2. [Configuration](configuration/index.md) — wire up the connection in
   `settings.php`, point Drupal's cache at Redis, and confirm the connection on
   the report page.
