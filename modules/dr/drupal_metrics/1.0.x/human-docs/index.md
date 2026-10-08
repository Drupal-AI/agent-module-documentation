# Drupal Metrics — manual setup guide

**Drupal Metrics** (`drupal_metrics`) adds a database‑metrics report to Drupal's
**Reports** section. It surfaces a clear overview of your site's structure —
notably the size of individual database tables and the total database footprint,
plus how content is distributed across content types — so both developers and
non‑technical stakeholders can understand how large and how content‑heavy a site
has become.

The problem it solves is visibility. Large or long‑running sites accumulate big
tables and uneven content distribution that quietly affect performance, and
finding that out usually means poking around in the database. This module puts
those numbers on an admin page instead: table sizes to help you spot tables worth
optimising, and content‑type counts to show how your content is structured. (The
project also lists multilingual‑coverage reporting as a planned, in‑progress
feature.)

It works as soon as you enable it — there is nothing to configure. It does add
its own permission, and the report is **admin‑facing operational data**, so grant
that permission only to trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the report permission.

There is **no settings form** for this module — it is a report, not a configurable
feature. The only access control is its permission, covered in Installation.

## Where it lives in the admin menu

Once enabled, the report appears under **Reports** (`/admin/reports`). Open it to
see database table sizes, the total database footprint, and content‑type
distribution for the site.
