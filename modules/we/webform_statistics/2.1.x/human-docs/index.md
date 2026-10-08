# Webform Statistics — manual setup guide

**Webform Statistics** (`webform_statistics`) adds **Statistics** tabs to the
Webform submissions area so you can see, at a glance, how many submissions each
form has received and when the latest one arrived — filtered to any date range
you like, with optional bar, line, spline, and area charts drawn with D3.

The whole module is built on Views. Enabling it installs one View,
`webform_statistics`, with four page displays — a general table plus per-day,
per-week, and per-month breakdowns — mounted as local tasks under the webform
submissions collection. There's nothing to configure: the tabs appear
automatically, gated by the same core **Administer webform submission**
permission that already controls who can see submissions.

The exposed filter is enhanced with proper HTML5 date pickers and a handy **Time
range** quick-select (last 24 hours, 7 / 30 / 90 / 180 / 365 days — default 90
days) that fills in the from/to dates for you. Because it is Views-based, you can
also reuse the module's building blocks — four Views field plugins (group by day,
latest submission date, submission label, submission language) and a **D3 Chart**
Views style — in your own custom submission reports.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Webform Statistics has **no settings page**. Once enabled, its tabs sit on the
webform submissions management screen:

- **General** — `/admin/structure/webform/submissions/statistics`
- **By day** — `/admin/structure/webform/submissions/statistics_day`
- **By week** — `/admin/structure/webform/submissions/statistics_week`
- **By month** — `/admin/structure/webform/submissions/statistics_month`

All four require the core **Administer webform submission** permission.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)). The
   `webform_statistics` View is installed automatically.
2. Go to **Structure → Webforms → Submissions** and click the new **Statistics**
   tab (`/admin/structure/webform/submissions/statistics`).
3. Use the **Time range** quick-select — or the from/to date pickers — to focus on
   a period (a campaign week, last quarter, and so on). Switch to the **By
   day/week/month** tabs to see counts grouped over time, rendered as tables and
   D3 charts.

### Reusing the pieces in your own reports

Because everything is Views, you can build bespoke submission analytics:

- Edit or clone the shipped View at
  `/admin/structure/views/view/webform_statistics` (needs **Administer views**).
  Note that re-running the module's update hook **overwrites** this View from its
  shipped definition, so persist custom changes in a **cloned** View, not the
  original.
- On any View of webform submissions, add the module's field plugins — *group by
  day* (`created_groupable`), *latest submission date*, *submission label*, and
  *submission language*.
- Set a display's **Format** to **D3 Chart** to render results as a bar, line,
  spline, or area chart; map the label (X-axis) and data fields, and tune the
  axis-label rotation, legend position, and data labels.

> **Note on charts:** the D3 v7 library is loaded from the jsDelivr CDN. Charts
> need outbound access to that CDN in the visitor's browser; the tables work
> regardless.
