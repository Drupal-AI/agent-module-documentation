# Hacked! — manual setup guide

**Hacked!** (`hacked`) tells you whether Drupal core or any of your contributed
modules and themes have been **changed from their official release**. Over the life
of a site, code drifts: someone applies a patch, hand-edits a module to fix a bug,
or a file gets modified and forgotten. Those changes are easy to lose track of —
and they matter, because an update can silently overwrite a local patch, and an
unexpected change might even be a sign of tampering. Hacked! makes that drift
visible.

It works by re-downloading the **official release** of each project at the version
you have installed, then comparing every file, hash by hash, against the copy on
your disk. Each project comes back as **Unchanged**, **Changed**, or **Unchecked**
(when it couldn't be downloaded or compared), with counts of how many files differ
or are missing. If you also have the **Diff** module installed, you can drill into a
changed project and see a file-by-file diff of exactly what was altered.

Two important things to understand: Hacked! only **reports** — it never edits,
reverts, or "fixes" your code, so it's completely safe to run. And it relies on
core's **Update** module for the list of projects and versions. You can run it from
the admin report page or entirely from the command line with its Drush commands.

It has a single setting — which "file hasher" to use, controlling whether Windows
vs Unix line-ending differences count as changes — so setup is genuinely minimal.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — run the report, read the results, the
   one setting, the Drush commands, and permissions.

## Where it lives in the admin menu

- The report is at **Reports → Hacked!** (`/admin/reports/hacked`).
- Force a fresh check at `/admin/reports/hacked/check`.
- The settings form is at **Reports → Hacked! → Settings**
  (`/admin/reports/hacked/settings`).

All report and settings pages are gated by core's **Administer site configuration**
permission; the per-file diff view has its own restricted permission.
