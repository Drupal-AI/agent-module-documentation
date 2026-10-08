# Pie Chart — manual setup guide

**Pie Chart** (`pie_chart`) provides configurable blocks that render data as a
responsive pie chart. The main block collects **Name | Value pairs** that you
enter and draws them as a pie chart you can place in any region. The module also
includes ready‑made structures for charting **content by node count** and for
charting **user roles with their user counts**, so you can visualise how content
or accounts are distributed across your site.

The charts are drawn with **Google Charts**, which means the module needs an
**internet connection** to load Google's charting library at render time. If the
site can't reach the internet, the chart block hides itself rather than showing a
broken chart — keep that in mind for offline or locked‑down environments.

Pie Chart is a display/visualisation feature. The role and node‑count charts
reflect content and user counts (following access where applicable), and the
module has **no access‑control role** of its own. Setup happens through Drupal's
normal block system, so there is no separate settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated configuration page** — you configure each chart when you
place its block, described under "How to use it" below.

## Where it lives in the admin menu

Pie Chart adds no settings page of its own. You place and configure its blocks at
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** and choose the region where the chart should
   appear, then click **Place block**.
2. Pick the Pie Chart block you want:
   - the **Name | Value** pie chart, where you type in your own label/value pairs;
   - the **content‑based** pie chart (node counts); or
   - the **user‑roles** pie chart (users per role).
3. For the Name | Value chart, enter your data pairs in the block configuration.
   Set the usual block visibility options (pages, roles) if you want to limit
   where it shows, and save.

The pie chart renders responsively in the chosen region. Remember it relies on
Google Charts, so the block only appears when the site can reach the internet.
