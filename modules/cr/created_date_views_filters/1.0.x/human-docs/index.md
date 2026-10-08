# Created Date Views Filters — manual setup guide

**Created Date Views Filters** (`created_date_views_filters`) adds two extra filters
to the Views UI that let you filter content by the **year** or the **month** of its
creation date (`created`), each as a simple dropdown instead of a raw timestamp
comparison.

- **Year filter** shows a dropdown of the last six years (the current year and the
  five before it) and matches content created in the year you pick.
- **Month filter** shows a dropdown of month names (January–December) and matches
  content created in that calendar month — **across every year**. Add the Year
  filter as well if you want a single month of a single year.

Under the hood each filter adds a small SQL condition on the `created` timestamp
(`EXTRACT(YEAR …)` / `EXTRACT(MONTH …)`). Two practical notes: that SQL is written
for **MySQL/MariaDB** and will not run on PostgreSQL or SQLite; and the module has
**no settings and no admin page** — it simply makes the two filters available inside
any view. It depends only on core's **Views** module and supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Views.

There is **no configuration page** for this module — it has no settings form. You
use it entirely from within the Views UI, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. Its filters appear inside the Views UI at
**Structure → Views** (`/admin/structure/views`) when you edit a view.

## How to use it

1. Edit or create a view at **Structure → Views**.
2. In the **Filter criteria** section, click **Add**.
3. Search for and add **Month filter: Filter** and/or **Year filter: Filter** —
   these are the two filters this module provides.
4. Configure each filter as you would any Views filter (for example exposing it so
   visitors can pick a month or year themselves), then save the view.

The filters restrict results to content created in the chosen year or month, rather
than requiring you to write a timestamp or offset by hand.
