# Migration queue importer — manual setup guide

**Migration queue importer** (`migrate_queue_importer`) runs your Migrate API
migrations automatically on **cron**, so you don't have to run `drush migrate` by
hand every time. You create a small config entity — a **cron migration** — for each
migration you want scheduled, telling it which migration to run and how often. On
every cron run the module checks which scheduled migrations are due and queues them
for import via Drupal's Queue API.

Each cron migration references a **migration plugin id**, an **interval** (in
seconds), and three per‑migration flags: **Update** (re‑import changed rows),
**Sync** (remove destination items no longer in the source), and **Ignore
dependencies** (skip dependency resolution). When a migration is due, the module
pushes it onto a queue; a queue worker then runs the import within a per‑run time
budget, so large imports spread across successive cron runs instead of timing out.
Unless you disable it, required dependency migrations are queued first,
automatically and in the right order.

Because schedules are stored as exportable configuration, you can deploy them
between environments with your normal config workflow, or isolate environment‑
specific ones with Config Split. It's a good fit for keeping content in sync with
an external feed, nightly ingestion of catalogs or event data, or any recurring
import you'd rather not babysit.

One practical note: the module deliberately **skips scheduling when cron is
triggered from the system cron settings form**, to avoid a long import blocking an
interactive request. To test a schedule, run real cron (`drush cron`) rather than
the admin "Run cron" button on that settings form.

It requires the **Migrate Tools** and **Migrate Plus** modules (plus core
Migrate), and provides one permission, **Administer cron migrations**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (along with Migrate Tools and Migrate Plus).
2. [Configuration](configuration/index.md) — creating cron migration entities, the
   interval and flags, and how scheduling actually runs.

## Where it lives in the admin menu

The admin screen sits at **Configuration → Development → Cron migration**
(`/admin/config/migrate_queue_importer/cron_migration`). Note that the module
declares no *Configure* link on the Extend page, so reach it via that menu link.
Access requires the **Administer cron migrations** permission.
