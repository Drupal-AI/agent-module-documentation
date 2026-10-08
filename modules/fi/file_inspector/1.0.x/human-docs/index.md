# File Inspector — manual setup guide

**File Inspector** (`file_inspector`) finds the files your site forgot about. It
scans the file system and identifies **unmanaged files** — files that exist on
disk but are not referenced by any Drupal entity (no record in `file_managed`) —
then lets administrators review them, delete them, or import them into the Media
library, all from a single report screen.

Over time every long-lived Drupal site accumulates orphaned files: leftovers from
deleted content, manual uploads copied in over SFTP, artefacts of a migration,
files restored from a backup, and output from third-party tooling. Drupal has no
idea they exist, so they never appear in the Media library, are never cleaned up,
and quietly become much of the site's storage. File Inspector gives you a clear,
actionable inventory of what is actually on disk versus what Drupal knows about,
and the tools to clean it up safely.

Inspection runs in two phases: it walks the configured stream wrapper(s) and
records every file it finds, then classifies each record as managed or unmanaged
by checking it against `file_managed`. It is built for scale — generator-based
iteration and the Batch API handle file systems with 100k+ files without
exhausting memory — and the results feed a Views-based report with status,
MIME-type, and date filters, per-row actions, and bulk operations.

Two things are worth weighing before you hand out access. The report is
effectively a **directory listing of the site's file system, including private
files**, and knowing that a file exists at a path is often most of the way to
reading it (for `public://` it is all of the way). And the module can **delete** —
and deleting a file Drupal does not track is irreversible in a way content
deletion is not: there is no revision, no unpublish, and no reference to tell you
what the file was for. Scan and inspect first, and treat any bulk delete as a
backup-first operation.

It depends on core's **Views** module (and optionally **Media**, for the import
feature) and requires Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the scan settings, the report, and
   the three permissions.

## Where it lives in the admin menu

- **Report** — **Reports → File Inspector** (`/admin/reports/file-inspector`).
- **Settings** — **Configuration → Media → File Inspector**
  (`/admin/config/media/file-inspector`).
