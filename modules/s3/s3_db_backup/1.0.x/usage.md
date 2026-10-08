<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AWS S3 Database Backup dumps the site database (via ifsnop/mysqldump-php) and either stores it on the local filesystem or uploads it to an AWS S3 bucket, keeping a downloadable history.

---

All admin routes under `/admin/config/s3-db-backup*` require the `administer s3_db_backup` permission (marked `restrict access: true`), covering the backup trigger, settings, table include/exclude, cron interval, history list and object download. AWS credentials come from a Key entity via the `key_aws` module (never stored in plain config); the S3 client uses the aws-sdk-php defaults (TLS enabled) and downloads use time-limited pre-signed URLs. Backups are written to a configurable path; the settings form warns when no private filesystem is configured and recommends private storage. A local adapter streams the dump as an attachment, and cron can run backups on an interval. The main residual risk is operator misconfiguration — pointing the backup path at a web-readable `public://` directory would expose the full database dump — so keep backups in the private filesystem.

---

- Schedule automatic database backups via Drupal cron.
- Upload database dumps to an AWS S3 bucket.
- Store backups on the local private filesystem instead of S3.
- Download a previous backup through a pre-signed S3 URL.
- Include or exclude specific tables from the dump.
- Compress dumps with gzip or bzip2.
- Keep a history of exports with timestamps in the UI.
- Use Key module + key_aws for AWS credentials, not plain config.
- Trigger an on-demand backup from the admin form.
- Support MySQL/MariaDB, PostgreSQL, SQLite and dblib.
- Run backups from the CLI via the provided Drush command.
- Point at a custom S3 endpoint (e.g. S3-compatible storage).
- Restrict all backup operations to the dedicated admin permission.
- Organise S3 objects into a configurable folder prefix.
- Warn admins when a private directory is not configured.
- Keep dumps out of the web root to avoid data disclosure.
