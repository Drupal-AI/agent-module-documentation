# Facet Bot Blocker — manual setup guide

**Facet Bot Blocker** (`facet_bot_blocker`) protects faceted-search pages from
crawlers that hammer your site with ever-deeper filter combinations. On a Search
API / Facets site, a bot can follow `?f[0]=…&f[1]=…&f[2]=…` links endlessly,
generating a near-infinite space of expensive, low-value URLs that load your
database and CPU and pollute search-engine indexes. This module cuts that off: once a
request's `f[]` facet array reaches a depth you configure, it returns a lightweight
**403 Forbidden** (or **410 Gone**) response *before* Drupal builds the page.

It works site-wide with no per-View or per-Facet wiring. A single, early request
listener checks each incoming request: if the visitor has drilled at least *limit*
facets deep, it short-circuits with a small configurable HTML message and stops
Drupal from rendering the costly faceted page. Users who hold the **Bypass facet bot
blocker** permission are never blocked, so you can let logged-in staff keep browsing
deep facets while shutting out anonymous crawlers. Returning **410 Gone** is a useful
option when you want search engines to actually *drop* those deep URLs from their
index.

The module also has an optional metrics dashboard at
`/admin/reports/facet-bot-blocker` showing how many requests are blocked vs allowed
and the last blocked IP/path/User-Agent — but those counters are only tracked when an
in-memory cache backend (**Memcache** or **Redis**) is installed; on a plain
database-cache site the dashboard shows the current limit but zeroed counters.
Settings live in `facet_bot_blocker.settings` and are edited at **Configuration →
System → Facet Bot Blocker**. The module defines three permissions, has no
dependencies beyond Drupal core, and ships no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and (optionally) add Redis/Memcache for metrics.
2. [Configuration](configuration/index.md) — the depth limit, the response code, the
   block message, the permissions, and the dashboard.

## Where it lives in the admin menu

- Settings: **Configuration → System → Facet Bot Blocker**
  (`/admin/config/system/facet-bot-blocker`), gated by *Administer facet bot
  blocker*.
- Dashboard: **Reports → Facet Bot Blocker** (`/admin/reports/facet-bot-blocker`),
  gated by *Access facet bot blocker dashboard*.

## How to use it

Enable the module, set the depth **limit** and choose whether over-limit requests get
403 or 410 on the settings form, then grant **Bypass facet bot blocker** to any
staff/authenticated roles that legitimately browse deep facets. See
[Configuration](configuration/index.md) for the details, including exactly which
requests get blocked at each limit value.
