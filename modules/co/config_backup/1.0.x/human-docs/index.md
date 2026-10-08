# Config Backup — manual setup guide

**Config Backup** (`config_backup`) makes it easy to **back up your site's
configuration** — creating a timestamped `.tar.gz` snapshot of the active
configuration (the same data as `drush config:export`). It works from the Drupal
admin UI or from the command line via `drush`, so you can grab a safety snapshot
before a risky change. The module creates archives only; restoring one is a manual
step (extract it into a config sync directory and run `drush config:import`).

The module builds on core's **Configuration Manager** (it depends on the `config`
module) and provides a single permission, **Backup configuration**, to gate who
can create backups. It's a straightforward administration/config-management tool
with no front-end footprint.

One important caveat: **configuration backups can contain sensitive values** — API
keys, credentials, or other settings — depending on how your site stores them. Treat
config backups as **sensitive artifacts**: restrict the **Backup configuration**
permission to trusted administrators, and set the backup directory somewhere secure
and not web-accessible (the README suggests a path outside the webroot).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the backup directory, grant the
   permission, and create backups from the UI or Drush.

## Where it lives in the admin menu

Config Backup adds a **Backup** tab under **Configuration → Development →
Configuration synchronization** (`/admin/config/development/configuration/backup`),
gated by its **Backup configuration** permission. The page shows the configured
backup directory and a single Backup button. You can also run backups from the
command line with `drush config:backup`. See
[Configuration](configuration/index.md).
