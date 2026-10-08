# SQLite Backup — manual setup guide

**SQLite Backup** (`sqlite_backup`) lets a site administrator create and restore
backups of a Drupal site's **SQLite database**. Most production Drupal sites run
on MySQL or PostgreSQL, but SQLite is wonderfully simple for smaller setups — the
Drupal desktop launcher is one example — and this module gives those SQLite‑backed
installs an easy way to snapshot the database file and roll it back later.

After you enable it, the module adds a **backup overview page** in the admin area
where you manage your SQLite backups: create a new snapshot, and restore an
earlier one. It provides its own permission for this, so you can control who is
allowed to run backups and restores. There is no separate settings form to fill in
— the overview page is the whole interface.

Two things to note. First, it **only works when the SQLite database driver is in
use**; on a MySQL or PostgreSQL site it does not apply. Second, this is an alpha
release and the module is minimally maintained. If you want database snapshots and
you already work at the command line with DDEV, `ddev snapshot` does a similar job;
SQLite Backup's value is offering the same convenience from inside Drupal's UI. It
runs on Drupal 10 and 11.

This guide is written for a **human** using the module through the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module.

## How to use it

Once enabled, open the module's **backup overview page** in the admin area. From
there you can create a new backup of the SQLite database and restore any existing
backup. Because a restore replaces your live database, grant the backup/restore
permission only to trusted administrators, and confirm you are on a SQLite‑backed
site before relying on it.
