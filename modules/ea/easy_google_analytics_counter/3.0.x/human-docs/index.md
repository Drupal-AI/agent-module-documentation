# Easy Google Analytics Counter — manual setup guide

**Easy Google Analytics Counter** (`easy_google_analytics_counter`) pulls
**aggregated page‑view counts from Google Analytics** and makes them available in
Drupal, so you can show "most viewed" content or sort and filter by popularity —
without maintaining your own view counter. The idea is efficiency: gathering and
aggregating visit statistics is expensive, but Google Analytics already does it for
free and exposes it through an API, so this module simply fetches those numbers on a
schedule and stores them where Views can use them. The **3.x** branch is **GA4
compatible**.

Once installed and configured, the module adds a **`page_views` column to the
`node_field_data` table**. That column is immediately usable in **Views** as a
field, a filter, and a sort — so building a "Top 10 most‑read articles" block, for
example, is just a matter of adding a View that sorts on it. A **cron** run keeps the
figures up to date by periodically re‑fetching from Google Analytics.

Because it talks to Google's API, it needs **credentials** for a Google Analytics
service/project, which you set up on the Google side and then reference in the
module's settings. **Treat those credentials as secrets** — see Installation. Note
the data flow is Drupal *reading* stats *from* Google Analytics (it is not itself the
visitor‑facing tracking snippet), but you should still be mindful of the credential's
scope and keep it limited to what's needed. The module works on Drupal 9, 10, and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with its Google API
   client library) and enable it.
2. [Configuration](configuration/index.md) — set up Google credentials, enter them,
   schedule cron, and use the data in Views.

## Where it lives in the admin menu

The settings form is at `/admin/config/easy_google_analytics_counter/admin`
(route `easy_google_analytics_counter.admin_form`). After configuring it and letting
cron run, the fetched counts appear as the **`page_views`** field on nodes, ready to
use in Views.
