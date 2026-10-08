# Google Analytics Light Report — manual setup guide

**Google Analytics Light Report** (`google_analytics_light_report`) brings your
**Google Analytics reports inside Drupal**. It uses the `google-api-php-client`
library to query the Google Analytics Reporting API and displays the results in the
admin, so site owners can see key metrics without leaving Drupal for an external
dashboard.

It provides three report **blocks**:

1. A summary of **Users, Sessions, Bounce Rate, and Pageviews**.
2. A **Pageviews list**.
3. **Top browsers** (by pageview) shown as a **pie chart**.

Each block lets you set the reporting **duration** in its block configuration. The
module also creates a dedicated report **page** at `/analytics-light-report` that
brings the different reports together, and a **line chart** for trends.

Access is split across two permissions: one for **viewing** the reports and one for
**administering** the module. Because it connects to Google with API credentials,
those credentials should be stored securely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   `google-api-php-client` library, and enable it.
2. [Configuration](configuration/index.md) — connect to the Google Analytics API,
   set permissions, and place the report blocks.

## Where it lives

The reports appear as **blocks** (place them via **Structure → Block layout**) and
on the bundled report page at `/analytics-light-report`. Viewing is gated by the
*View Google Analytics report (light)* permission and administration by the
*Administer Google Analytics Light Report* permission.
