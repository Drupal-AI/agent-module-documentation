# Digital.gov Site Scanner — manual setup guide

**Digital.gov Site Scanner** (`idealyzer`) helps agencies check whether their
website meets the guidelines of the **21st Century Integrated Digital Experience
Act (IDEA)** and related federal requirements. It runs automated compliance
checks and presents a clear status overview right inside the Drupal admin — no
external scanning service required.

The scanner covers things like IPv6 compliance, Digital Analytics Program (DAP)
integration, and U.S. Web Design System (USWDS) implementation, among others.
Each check returns detailed, actionable insight so you can see not just whether
you pass, but what to fix if you don't. Because it runs from within Drupal, you
can re‑check compliance regularly and track it over time.

The module has no dependencies beyond Drupal core and works on Drupal 8 through
11. It is primarily a **reporting tool** — there is nothing you must configure to
get a first read on your site's status.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no settings form** — you use it from its report page,
described below.

## Where it lives in the admin menu

Once enabled, the compliance overview lives under **Reports** at
`/admin/reports/gov-status`. Open that page to see each compliance check and its
status.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Reports → 21st Century IDEA site status**, or navigate directly to
   `/admin/reports/gov-status`.
3. Review each check and its detailed insight, then work through any gaps it
   flags. Re‑visit the page whenever you want to confirm your current status.
