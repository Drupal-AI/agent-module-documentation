# Unused Modules — manual setup guide

**Unused Modules** (`unused_modules`) helps you find the modules and projects
sitting in your codebase that are fully disabled and therefore safe to remove. On
a long-lived site the modules directory tends to accumulate contrib projects that
were tried and abandoned, or left behind after a feature was dropped. This module
scans everything on disk, ignores core, and tells you what's genuinely unused — via
both an admin report and a Drush command.

It draws a careful distinction between a **module** and a **project**. A module is
"unused" when it's disabled. A **project** (a downloadable Drupal.org project such
as *Views*, which may contain several modules like `views` and `views_ui`) is only
listed as "safe to delete" when **none** of its modules are enabled. That way you
won't be told to delete a project that still has an enabled submodule.

Importantly, Unused Modules is **read-only** — it never uninstalls or deletes
anything for you; it only reports. The workflow is yours: uninstall the modules
first, then remove their directories (and Composer packages), always with a backup
in hand. It also ships **Site Audit** integration so the same check can run inside
a Site Audit report.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the Drush arguments, output
columns, and the helper service — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — read the report pages, use the Drush
   command, and understand the "safe to delete" rules.

## Where it lives in the admin menu

The report is at **Configuration → Development → Unused Modules**
(`/admin/config/development/unused_modules/...`). It has tabs for **Projects** vs
**Modules** and sub-tabs for **Fully disabled** vs **Also enabled**. All of it is
gated by the core **Administer modules** permission — the module adds no permission
of its own. See [Configuration](configuration/index.md) for how to read it.
