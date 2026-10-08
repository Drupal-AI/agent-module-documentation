# Migrate: Skip File On Not Exists — manual setup guide

**Migrate: Skip File On Not Exists** (`migrate_skip_on_404`) keeps a migration
running when some of its source files are missing. Normally, if a file migration
tries to copy a file that no longer exists on the old server, the whole file
migration fails — a frequent headache when upgrading a Drupal 6 or 7 site whose media
library has drifted over the years. This module makes a missing file skip its row
(or just its file value) instead of aborting the run.

It works in two ways. First, it provides a reusable migrate **process plugin** called
`skip_on_404` that you can add to any custom migration to check whether a file exists
before the pipeline continues — it uses a lightweight HTTP `HEAD` request for external
URLs and a normal file‑existence check for local paths, so both public and private
files are covered. Second, and most conveniently, it **automatically** injects that
plugin into Drupal's standard Drupal‑7 file migrations, so a Migrate Drupal UI or
Migrate Upgrade run tolerates missing public and private files with **zero
configuration**.

Every skipped file leaves a diagnostic message in the migration's message table, so
afterward you can audit exactly which legacy files were absent. Because there is
nothing to configure for the automatic behavior, a common pattern is to enable the
module just before an upgrade and disable it after — there is no config to clean up.

This module is aimed at developers and site builders running migrations; there is
**no admin UI, settings page, or permissions**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — the module has no admin page. It works entirely inside the Migrate system:
automatically for the standard D7 file migrations, and by name (`skip_on_404`) in any
custom migration you write.

## How to use it

### Automatic (standard upgrades)

Just enable the module. It splices `skip_on_404` into core's Drupal‑7 file migrations
(`d7_file`, `d7_file_private`, and the Migrate Upgrade equivalents), so a subsequent
upgrade run — through the Migrate Drupal UI or Migrate Upgrade via Drush — silently
skips missing files instead of failing. Nothing else to do.

### In a custom migration

Reference the plugin by name in your migration's process pipeline. Use
`method: row` to drop the whole record when the file is missing, or `method: process`
to drop only the file value while keeping the rest of the row:

```yaml
process:
  uri:
    -
      plugin: skip_on_404
      method: row
      source: fileurl
    -
      plugin: file_copy
      source:
        - fileurl
        - '@destination'
```

Each skipped file is logged to the migration's message table (for example
"404 - … does not exist"), so you can review which files were absent once the run
completes.
