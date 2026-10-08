# CWV — manual setup guide

**CWV** (`cwv`) is self‑hosted **real‑user Core Web Vitals** monitoring for
Drupal. It bundles the standard `web-vitals` JavaScript, which captures the five
headline field metrics — **LCP, INP, CLS, FCP, and TTFB** — from your real
visitors' browsers and posts them back to a beacon endpoint inside your own
Drupal site. Nothing is sent to a third‑party service and there are no external
JavaScript calls; the data stays in your database.

What makes CWV more than a raw metrics logger is that it *correlates* each
measurement with Drupal‑side signals — the route, the user's role, page‑cache
state, render‑tree size, database query count, OPcache/APCu health, edge/CDN
cache state, and more — through an extensible collector system. Report panels at
**Reports → CWV** (`/admin/reports/cwv`) then join the browser metrics to those
backend signals, so you can answer questions like *"does the page cache hit rate
predict LCP on this route?"* or *"did the count of poor beacons shift after
Tuesday's deploy?"*

One thing to know before you rely on it: **capture is off after install.** CWV
deliberately ships collecting nothing so you can review its privacy and sizing
posture first. You turn capture on, set a sampling rate, and choose how much of
each URL to store on the settings form — see [Configuration](configuration/index.md).
It requires Drupal 10.3 or 11 and has no third‑party dependencies. Permissions
cover administration (`administer cwv`) and viewing the reports (`view cwv
reports`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn capture on, set the sampling
   rate and URL‑storage policy, and understand the privacy and sizing controls.

## Where it lives in the admin menu

The reports live at **Reports → CWV** (`/admin/reports/cwv`), gated by the *view
cwv reports* permission. Administration and the capture settings are gated by the
*administer cwv* permission. Because capture starts off, expect the report panels
to be empty until you enable capture and real visitors begin sending beacons.
