# HTTP Status Code Test — manual setup guide

**HTTP Status Code Test** (`http_status_code_test`) registers a small test
endpoint that returns whatever HTTP status code you ask for in the request. For
example, requesting `https://example.com/http-status-code-test?code=503` makes
Drupal respond with a `503` status code.

It exists so you can deliberately trigger a specific status code on demand — very
handy when you need to test how downstream services react. A CDN such as Akamai
or Cloudflare can be configured to intercept certain status codes and serve a
custom error page; with this module a developer can force that exact code and
confirm the custom page appears. It's equally useful for exercising monitoring,
alerting, and load‑balancer health checks.

This is a **developer and testing tool**, and it should be treated as one. An
endpoint that can return arbitrary status codes could be abused to fake an outage
or confuse your monitoring, so keep it disabled unless you are actively using it,
gate it behind its permission, and do not leave it enabled on production. The
endpoint ships **disabled by default** for exactly this reason.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module has two settings, both on its own settings form:

- **Enabled** — whether the test endpoint is active. It is **`false` (off) by
  default**, so nothing responds until you deliberately switch it on. Turn it off
  again as soon as you finish testing.
- **Endpoint Path** — the path the endpoint is registered at. The default is
  `/http-status-code-test`. Change it if that path clashes with something on your
  site.

With the endpoint enabled, request the path and pass the status code you want in
the `code` query‑string parameter — for instance `/http-status-code-test?code=404`
returns a `404`. Point your CDN, monitoring, or load‑balancer test at that URL to
verify how it handles the code.

Because the endpoint can impersonate any status, restrict who can reach it using
the permission the module provides (grant it at **People → Permissions**), and
disable the endpoint when you are done.
