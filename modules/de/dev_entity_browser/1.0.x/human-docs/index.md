# Developer Entity Browser — manual setup guide

**Developer Entity Browser** (`dev_entity_browser`) gives developers a single,
unified dashboard for inspecting a site's data model. From one screen you can
navigate all content entities and their bundles, see aggregated field names, and
review configuration settings — a quick way to understand how a site's entities,
bundles and field architecture fit together without hopping between many admin
pages. If you've reached for Devel to explore entities and fields, this offers a
more focused, at-a-glance view of the same territory.

It adds a report (reachable from the **Reports** menu) and ships its own
permission. Because the dashboard reveals the site's structure and configuration —
sensitive operational detail — treat it as a **development-only tool**: grant its
permission only to trusted developers and administrators, and don't expose it to
untrusted users, especially on production. It has no content-access role beyond
gating who can open the report.

The module has no third-party dependencies, supports Drupal 10 and 11, and is
covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the report permission.

There is no settings form for this module — the only setup is granting the
permission below.

## Where it lives in the admin menu

Once enabled and permitted, you'll find the report under the **Reports** menu
(`/admin/reports`).

## How to use it

1. Enable the module.
2. Go to **People → Permissions** and grant **View Dev Entity Browser** to your
   developer/administrator roles (only trusted roles — the report exposes site
   structure and configuration).
3. Open the report from the **Reports** menu and browse entities, bundles, fields
   and configuration.
