# Migrate Helper — manual setup guide

**Migrate Helper** (`migrate_helper`) is a grab‑bag of convenience utilities for
people who build and run Drupal migrations. Where core's Migrate framework gives
you the raw machinery, this module adds the small everyday tools that save you
from writing boilerplate or squinting at Drush output — inspecting a migration's
source, checking status quickly, browsing the migration tables, and cleaning up
the debris a migration leaves behind.

According to its project page it offers: a **source lookup** (view a migration's
source information for an entity via an admin tab), a **quick status** check that
avoids the HTTP/row‑count overhead of the usual status command, **migration info**
for inspecting migration tables and configuration, a **list‑tables** view that
shows every migration table and flags orphaned ones, a **cleanup‑stubs** action
that removes the orphaned stub entities a completed migration can leave behind,
and a **rename** tool that renames one migration by ID — or many at once by
prefix — without losing the map and message data.

It depends only on core's **Migrate** module and targets **Drupal 10.1+ and 11**.
This is developer/site‑builder tooling: there is no site‑visitor‑facing feature,
and it defines its own permissions to gate the admin tools. The module works as
soon as it is enabled — there is nothing you must configure first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Migrate.

There is **no configuration page** for this module — it ships no settings form.
Its tools appear as admin tabs and actions once it is enabled, described below.

## How to use it

Migrate Helper adds its utilities to Drupal's existing migration administration
rather than introducing a settings screen of its own:

- **Source lookup** — from an entity you can open a tab that shows the migration
  source information behind it, so you can trace a piece of migrated content back
  to the row it came from.
- **Quick status** — check whether a migration has run, and how far, without the
  overhead of a full row count.
- **Migration info / list tables** — inspect the migration's tables and
  configuration, and see all migration tables at a glance, with orphaned ones
  identified.
- **Cleanup stubs** — remove orphaned stub entities that a migration created as
  placeholders but never filled in.
- **Rename migrations** — rename a single migration by its ID, or rename many at
  once by a shared prefix, while preserving the existing map and message tables.

Because these tools act on real migration data (including deletions such as
stub cleanup), keep a database backup before using the destructive actions, and
restrict the module's permissions to trusted developers and site builders.
