<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS S3 Database Backup (s3_db_backup) — agent index

**Database backup to local filesystem or AWS S3, with UI, cron and Drush.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10
- **Depends:** key_aws (Key module AWS provider)
- **Configure:** `/admin/config/s3-db-backup/settings`
- **Permission:** `administer s3_db_backup` (restrict access)

**Surface:** routes for export/settings/tables/cron/history/download — ALL gated by `administer s3_db_backup`. Adapters: AWS, local, remote (`src/Adapter/*`). AWS creds via `key_aws` Key entity.

**Security review:** no anon/low-priv route; download uses pre-signed URLs (`getPresignedUrl`); S3 client uses aws-sdk-php default TLS. Creds not stored in plain config. Residual risk is operator misconfig — a `public://` backup path would expose the DB dump; the settings form warns and recommends the private filesystem. No code-level vuln found.
