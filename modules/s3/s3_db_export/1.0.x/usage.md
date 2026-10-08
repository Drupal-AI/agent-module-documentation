<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
S3 DB Export automates SQL database backups: it runs a mysqldump (via `ifsnop/mysqldump-php`) and, when enabled, uploads the resulting file to an Amazon S3 bucket using the AWS SDK.

---

Configuration lives at `/admin/config/content/DbForm` (route `s3_db_export.admin_settings`, gated by permission `administer Dbexport settings` AND role `administrator`), where you enter the AWS region, version, key, secret, bucket and folder — all persisted through Drupal's `state` service. The `DbexportManager` service performs the dump into `public://tmp/`, naming files `backup_<time><rand>.sql`, and `awss3()` uploads that file to the bucket. Two additional routes exist: `s3_db_export.export` (`/db-export-s3`) triggers a dump+upload, and `s3_db_export.download` (`/db-export-s3-download`) streams the freshly dumped SQL file to the browser; both require the same permission+administrator role. A bundled Ultimate Cron job and `hook_cron` can drive the export on a schedule.

Security-relevant behavior to be aware of when operating this module: the dump is written to the public files directory (`public://tmp/`) — a web-accessible location — with a semi-predictable timestamp+`rand()` filename, and the code never deletes it (an in-code `@todo` acknowledges this), so a full database dump can remain downloadable by anyone who guesses/enumerates the path. AWS credentials are stored in `state` (plaintext in the database), not the Key module. Trigger routes are correctly restricted to the administrator role. Recommended hardening: use a private stream and delete the dump after upload, and store credentials via the Key module.

---

- Take an on-demand SQL dump of the site database.
- Upload a database backup to an Amazon S3 bucket.
- Schedule automatic database exports via cron.
- Run scheduled exports through the bundled Ultimate Cron job.
- Configure the AWS region for uploads.
- Configure the AWS API version string.
- Store the AWS access key for S3.
- Store the AWS secret key for S3.
- Set the destination S3 bucket name.
- Set a folder/prefix inside the bucket.
- Download the latest SQL dump from the browser.
- Toggle whether dumps are pushed to S3 or just created locally.
- Keep offsite backups for disaster recovery.
- Restrict export/download actions to administrators.
- Produce a `backup_<timestamp>.sql` file for archiving.
- Integrate database backups into an AWS data-protection workflow.
- Trigger an export from the `/db-export-s3` route.
- Generate a backup before a deployment or migration.
- Move dumps to cheaper S3 storage tiers via bucket lifecycle rules.
- Verify AWS settings by running a manual export.
