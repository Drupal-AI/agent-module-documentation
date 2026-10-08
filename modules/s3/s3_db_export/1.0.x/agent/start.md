<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exports Drupal databases to AWS S3 (s3_db_export) — agent index

**Runs mysqldump into public://tmp and uploads the SQL file to an Amazon S3 bucket, on demand or via cron.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Libs:** ifsnop/mysqldump-php ^2, aws/aws-sdk-php ^3
- **Config route:** `s3_db_export.admin_settings` → `/admin/config/content/DbForm`
- **Action routes:** `s3_db_export.export` (`/db-export-s3`, dump+upload), `s3_db_export.download` (`/db-export-s3-download`, streams the SQL). All three require permission `administer Dbexport settings` AND `_role: administrator`.
- **Service:** `s3_db_export.manager` (`DbexportManager`) — `dump()`, `dbExport()`, `awss3()`.

**Security:** trigger/config routes are restricted to the administrator role (good). Concerns to flag to operators: (1) dumps are written to the WEB-ACCESSIBLE `public://tmp/` with a predictable `backup_<time><rand>.sql` name and are never deleted — a full DB dump can be enumerated/downloaded; (2) AWS key/secret are stored in `state` (plaintext in DB), not the Key module.

See [configure/s3_db_export.md](configure/s3_db_export.md)
