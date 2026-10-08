# Field Data (Local Tasks More) — manual setup guide

**Field Data** (`field_data`) extends Drupal core's **Field list** report with an
extra **Data** tab. Core already lists every field on your site at **Reports →
Field list** (`/admin/reports/fields`); this module adds a tab there that lets
administrators **view — and download — field data**, giving deeper insight into how
fields are used across the site.

It is a site‑building / administration tool. It surfaces admin‑facing field
information only; it does not change content, and beyond its own permission it plays
no access‑control role. It builds on core's **Field UI** and **Options** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no settings form** — the module simply adds a report tab, described in
"How to use it" below.

## Where it lives in the admin menu

Look under **Reports → Field list** (`/admin/reports/fields`) — after enabling the
module you will find a new **Data** tab alongside the existing field report.

## How to use it

1. Make sure the roles that need it have the module's permission (grant it on
   **People → Permissions**, `/admin/people/permissions`).
2. Go to **Reports → Field list** (`/admin/reports/fields`).
3. Open the **Data** tab to view the field data, and use the download option to
   export it for offline review.

If you need related tooling, the project points to
[Schema Viewer](https://www.drupal.org/project/schema_viewer),
[Entity Export CSV](https://www.drupal.org/project/entity_export_csv), and
[Content Export CSV](https://www.drupal.org/project/content_export_csv) as
complementary modules.
