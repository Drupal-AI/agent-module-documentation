<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Backup and Migrate: AWS S3 adds an "AWS S3" destination type to the Backup & Migrate module so scheduled or manual backups are stored in an Amazon S3 (or S3-compatible) bucket, with credentials supplied through the Key module.

---

The module registers a `awss3` `BackupMigrateDestinationPlugin` whose wrapped class
`\Drupal\backup_migrate_aws_s3\Destination\AWSS3Destination` implements Backup & Migrate's
remote/listable/readable destination interfaces on top of the `aws/aws-sdk-php` `S3Client`. A
destination's config (endpoint/host, bucket, optional sub-folder prefix, region, and Key
references for the access/secret keys) is entered through Backup & Migrate's own destination UI;
the field schema comes from `AWSS3Destination::configSchema()`. Credentials are **never stored by
this module** — you select Key entities managed by the required `key` module, and the client
reads them at runtime via `key.repository`; if the optional `key_aws` module is present a single
AWS credentials-file key can be used instead. Saving a backup uploads the file with
`putObject()` (adding a SHA-256 checksum when the bucket has S3 Object Lock enabled); listing,
downloading, and restoring use `getIterator('ListObjects')`, `getObject()`, and `deleteObject()`,
all scoped to the configured bucket + folder prefix. A route subscriber repoints Backup &
Migrate's `backup_download` route to this module's controller so S3-stored backups can be
downloaded through the browser; that route keeps Backup & Migrate's existing access checks. A
custom `s3_endpoint` lets you target S3-compatible services (MinIO, Wasabi, DigitalOcean Spaces,
etc.). There is no config page of its own — configuration happens inside Backup & Migrate at
`/admin/config/development/backup_migrate`.

---

- Store Drupal database/file backups off-site in an Amazon S3 bucket.
- Add S3 as a Backup & Migrate destination alongside local/private-file destinations.
- Schedule automated backups (via Backup & Migrate schedules) that upload to S3.
- Keep credentials out of config by referencing Key-module keys for the access and secret keys.
- Use a single AWS credentials-file key via the optional Key AWS (`key_aws`) module.
- Organize backups into a sub-folder (prefix) within a shared bucket.
- Target a specific AWS region for data-residency/compliance requirements.
- Back up to S3-compatible object storage (MinIO, Wasabi, DigitalOcean Spaces, Ceph) via a custom endpoint.
- Download an S3-stored backup through the Backup & Migrate UI (browser download).
- Restore a site from a backup pulled back out of S3.
- List and browse existing backups stored in the bucket/prefix.
- Delete old backups from S3 through Backup & Migrate's destination management.
- Satisfy 3-2-1 backup strategy by adding a cloud copy of on-server backups.
- Support S3 Object Lock / WORM buckets (module adds a SHA-256 checksum on upload when lock is enabled).
- Rotate AWS credentials centrally by updating the referenced Key entity, no destination reconfig.
- Separate access and secret keys into two distinct Key entities.
- Provide disaster-recovery storage independent of the web server's filesystem.
- Move backups to cheaper cold storage tiers by pointing at a lifecycle-managed bucket.
- Use IAM-scoped credentials limited to a single backup bucket.
- Migrate a site between environments by backing up to S3 and restoring elsewhere.
