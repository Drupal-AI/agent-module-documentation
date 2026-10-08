# AWS S3 Database Backup — manual setup guide

**AWS S3 Database Backup** (`s3_db_backup`) creates database backups of your Drupal
site and either keeps them on the local filesystem or uploads them to an **Amazon S3**
bucket, with a downloadable history you can browse in the admin UI. Under the hood it
uses the `mysqldump-php` library to produce the dump and the AWS SDK to push it to S3.

It's built for real backup workflows: you can include or exclude specific tables,
compress dumps with gzip or bzip2, keep a timestamped history, trigger a backup
on demand from the admin form, schedule backups with Drupal **cron** at a
configurable interval, and generate backups from the command line with a **Drush**
command. It supports MySQL/MariaDB, PostgreSQL, SQLite, and dblib, and can point at a
custom S3 endpoint for S3‑compatible storage.

**Treat these backups as highly sensitive.** A database dump contains *everything* on
your site — user accounts, hashed passwords, session data, private content. Two
things follow from that. First, credentials: this module stores your AWS access and
secret keys through the **Key** module (via the `key_aws` provider), never in plain
configuration — keep it that way. Second, storage location: keep backups in the
**private** filesystem, never a web‑readable `public://` directory, or the whole
database could be downloaded by anyone who finds the path. The settings form warns you
when no private filesystem is configured. Downloads from the UI use time‑limited
pre‑signed S3 URLs, and every backup route is gated by a dedicated admin permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its Key AWS dependency.
2. [Configuration](configuration/index.md) — store your AWS credentials securely,
   point at your bucket, choose the filesystem, and set up cron and Drush.

## Where it lives in the admin menu

The settings form is at **Configuration → S3 DB Backup → Settings**
(`/admin/config/s3-db-backup/settings`), and you run and download backups from
**Configuration → S3 DB Backup** (`/admin/config/s3-db-backup`). All of these require
the **`administer s3_db_backup`** permission. See [Configuration](configuration/index.md).
