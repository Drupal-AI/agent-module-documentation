# Page Proxy — manual setup guide

**Page Proxy** (`page_proxy`) lets Drupal act as a reverse proxy for an external
website: you map a Drupal path to a remote target, and Drupal fetches that target
server‑side and serves it under your own path. If your site is at `foo.org`, you can
make `bar.org` available at `foo.org/bar` — Drupal routes any request under
`foo.org/bar` to `bar.org` and sends the response back to the visitor.

This is useful when your users can reach Drupal, and the server Drupal runs on can
reach the remote site, but your users cannot reach the remote site directly. (If
they *can* reach it directly, another approach is usually better.) An administrator
defines the proxy routes; the target host is fixed by that configuration, not chosen
per request.

Because Drupal makes the outbound request on the server's behalf and forwards
selected cookies and headers, treat Page Proxy as a sensitive integration. Point it
only at hosts you trust, keep its configuration permission restricted, and serve
over HTTPS. The [Configuration](configuration/index.md) page covers these
considerations in more detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define proxy routes, and the security
   considerations to weigh first.

## Where it lives in the admin menu

After installation, create and manage proxy configurations at **Configuration →
Web services → Page Proxy** (`/admin/config/services/page-proxy`). The form is
gated by the **Administer site configuration** permission.
