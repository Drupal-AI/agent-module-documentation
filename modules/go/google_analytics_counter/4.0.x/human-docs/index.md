# Google Analytics Counter — manual setup guide

**Google Analytics Counter** (`google_analytics_counter`) is a lightweight
**page-view counter** that pulls real view figures from **Google Analytics** back
into Drupal and stores them per node. Once the numbers are in Drupal, you can build
"most read" listings, sort views by popularity, and show a view counter on a page —
all from accurate analytics data rather than Drupal's own request counting.

Why not just use core's Statistics module? Because core counts requests itself,
which is inaccurate behind a CDN or page cache and adds a database write to every
page view. This module takes the opposite approach: Google Analytics already counts
views accurately, so it **fetches those numbers on cron** and stores them locally,
with no per-request write.

An important thing to understand: this module does **not** add tracking JavaScript
to your pages — that is the separate **Google Analytics** module's job. This one
only *reads the resulting figures back* via the Google Analytics API. A working
setup therefore usually needs both modules. And because the data is a periodic
snapshot synced on cron, the counts lag reality by your cron interval — don't use
it where a live, to-the-second counter is expected.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect to the Google Analytics API,
   choose which content types get a counter field, and run the sync.

## Where it lives in the admin menu

The main settings form is at **Configuration → System → Google Analytics Counter**
(`/admin/config/system/google-analytics-counter`, route
`google_analytics_counter.admin_settings_form`). A second form configures which
content types carry a counter field, and a dashboard reports sync progress. All of
these are gated by the single **Administer Google Analytics Counter** permission.

## How to use the data

Once cron has populated the figures, the counts are available to **Views** (via the
module's Views integration) for building "most popular" blocks and listings, to a
**counter field** you can place on nodes, and to a **block** and a **token** the
module provides. Build your popularity listings on top of the counter field.
