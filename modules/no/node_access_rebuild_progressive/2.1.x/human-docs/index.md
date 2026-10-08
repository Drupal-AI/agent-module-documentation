# Node Access Rebuild Progressive — manual setup guide

**Node Access Rebuild Progressive** (`node_access_rebuild_progressive`) is a
site-builder / developer tool that rebuilds Drupal's node access grants table **in
chunks** instead of all at once. Drupal's stock "Rebuild permissions" button
reprocesses every node in a single request, which reliably times out or runs out of
memory on large sites — especially sites using heavy node-access modules like Group,
Domain Access, or Workbench Access. This module replaces that all-or-nothing rebuild
with a progressive one that works through nodes a chunk at a time (500 by default).

Because it tracks its position as it goes, a rebuild is **interruptible and
resumable**: if it stops, you can pick up where it left off. You run it either as a
resumable **Drush command**, or you can let it run **incrementally on cron**,
processing one chunk per cron run so a huge rebuild spreads out over time without
knocking the site over. A lock prevents cron and Drush from stepping on each other.

To steer admins toward the safe path, the module also **disables Drupal core's own
"Rebuild permissions" form** and replaces its text with instructions to run the Drush
command instead. A small settings page lets you tune the chunk size and turn cron
processing on or off, and the Drush command can target only specific content types.

This guide is written for a **human** running the rebuild and tuning its settings.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form (chunk size and cron
   mode), and how to run a rebuild with Drush.

## Where it lives in the admin menu

- **Settings form:** *Configuration → Development → Node Access Rebuild Progressive*
  (`/admin/config/development/node-access-rebuild-progressive`), where you set the
  chunk size and toggle cron processing. It requires the *administer site
  configuration* permission.
- **Core's "Rebuild permissions" form** (reached from *Reports → Status report* when
  a rebuild is needed) is intentionally **disabled** by this module and points you at
  the Drush command instead.

## How to use it

Most people simply run the Drush command:

```bash
drush node-access-rebuild-progressive
```

It only does work if Drupal actually needs a rebuild. If a rebuild is interrupted,
resume it with `--resume`. Full options — including forcing a rebuild, resuming, and
limiting to specific content types — plus the cron-based approach are covered in
[Configuration](configuration/index.md).
