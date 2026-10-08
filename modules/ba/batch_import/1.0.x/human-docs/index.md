# Batch Import — manual setup guide

**Batch Import** (`batch_import`) runs Migrate imports in batches, so large data
sets can be brought in without hitting PHP timeouts or running out of memory, and
with progress reported as it goes. It sits in the Migration space and is aimed at
the person running a migration, not at everyday content editors.

It provides its own permission so you can control who may run imports. Beyond
that it has no access‑control role. Because a migration processes source data with
migration privileges — potentially creating or changing a lot of content — it is
a tool for a **trusted operator**: validate your source data first, and only give
the permission to people you trust to run imports.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Once enabled, Batch Import adds its import operation to the admin UI (under the
**Migration** package), reachable by users who hold its permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Grant the Batch Import permission only to the trusted operator(s) who should
   run migrations.
3. Validate your source data before importing — a migration runs with migration
   privileges and can create or change a lot of content.
4. Run the batched import; the work is chunked so large data sets complete
   without timing out, and progress is shown as it runs.
