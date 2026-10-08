# Backup and Migrate — manual setup guide

**Backup and Migrate** (`backup_migrate`) backs up and restores your Drupal
**database and files**, and can move a site between environments — all from the
admin UI, from cron, or from Drush. You can take an **on-demand** backup before a
risky update, set up **scheduled** nightly backups, **restore** the site from a
saved archive, and send backups to **off-site destinations** so they survive a
server failure.

Backups are produced from configurable **sources** (the default database, a MySQL
database, the entire site, or a files directory) and written to configurable
**destinations** (a server directory, the private or public files directory, or a
direct download to your browser). A **restore** workflow reads a backup file back
into the site, making it easy to roll back a bad change or clone content between
staging and production.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to taking your first
backup. If you are looking for terse, token-cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Backup and Migrate Quick Backup form, showing a Backup Source and Backup Destination to choose before backing up](images/quick-backup.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Development → Backup and
Migrate** (`/admin/config/development/backup_migrate`). That page is organised into
tabs across the top:

- **Backup** — take a backup now. Has two sub-tabs: **Quick Backup** (pick a source
  and destination and go) and **Advanced Backup** (more options).
- **Restore** — load a backup file back into the site.
- **Saved Backups** — browse, download, or restore backups already stored in a
  destination.
- **Schedules** — set up recurring, cron-driven backups.
- **Settings** — reusable settings profiles, sources, and destinations.

## Contents

1. [Installation](installation/index.md) — install Backup and Migrate with Composer
   and enable it.
2. [Configuration](configuration/index.md) — run your first Quick Backup, then set
   up settings profiles, schedules, saved backups, and restore.
