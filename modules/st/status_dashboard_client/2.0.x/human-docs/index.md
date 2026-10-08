# Status dashboard client — manual setup guide

**Status dashboard client** (`status_dashboard_client`) is the small companion you
install on each site you want to monitor. It exposes a single, **secret-protected
JSON endpoint** reporting that site's health: its Drupal core version, the full
list of enabled modules and their versions, which projects have **pending security
updates**, which have non-security **feature updates** available, the site name and
URL, and a count of status-report requirement errors. A central **Status Dashboard**
site — installed separately on a monitoring site — polls these endpoints across all
your client sites and aggregates the results, optionally emailing notifications.

It's aimed at agencies and ops teams managing a fleet of Drupal sites: instead of
logging into each site's `/admin/reports/updates` one at a time, you get a single
pane of glass showing which sites are drifting out of date or running
known-vulnerable modules. Because the endpoint returns machine-readable JSON, it can
also feed an external monitoring pipeline, and developers can extend the payload
(for example to append PHP version or last cron run) via a hook.

Setup is minimal: install the module, then set a **shared secret**. The central
dashboard is configured with each client's URL and that secret, and every poll must
carry the secret in a request header. There's one settings form (a single secret
field) and one permission. It depends only on core's **Update** module.

> **Set a secret after enabling.** The module ships with no secret set; setting a
> strong secret is the first thing to do — see
> [Configuration](configuration/index.md).

This guide is written for a **human** setting the client up through the admin UI. If
you want terse, token-cheap references for an AI coding agent (the endpoint, access
check, JSON payload, and the alter hook), read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the shared secret, understand the
   endpoint and its payload, and connect the central dashboard.

## Where it lives in the admin menu

Its settings form is at **Configuration → Development → Status dashboard client**
(`/admin/config/development/status-dashboard-client`), gated by the **Administer
status_dashboard_client configuration** permission. The reporting endpoint itself
is at `/status_dashboard/check`.

## How to use it

Install the module on each client site, set a strong shared secret on the settings
form, then register that site's URL and secret in the central Status Dashboard
site so it can poll `/status_dashboard/check`. See
[Configuration](configuration/index.md) for the details.
