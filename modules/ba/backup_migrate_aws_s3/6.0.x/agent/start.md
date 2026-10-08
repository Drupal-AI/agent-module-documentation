<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backup and Migrate: AWS S3 — agent index

Adds an **AWS S3** destination (`awss3`) to the Backup & Migrate module. Credentials come from
the **Key** module (both required). Uses `aws/aws-sdk-php`. No config page of its own — configure
inside Backup & Migrate (`configure` route `backup_migrate.quick_backup`). No permissions, no
Drush, no config schema of its own.

- **Creating/configuring an S3 destination: fields, Key setup, key_aws, S3-compatible endpoints** →
  [configure/destination.md](configure/destination.md)
- **The `AWSS3Destination` class, S3 client construction, object lock, the download route override** →
  [extend/integration.md](extend/integration.md)

Key facts:
- Destination plugin: `awss3` (`AWSS3DestinationPlugin`, wrapped class
  `\Drupal\backup_migrate_aws_s3\Destination\AWSS3Destination`).
- Destination config fields: `s3_endpoint`, `s3_bucket` (required), `s3_folder_prefix`,
  `s3_region` (required), and Key refs `s3_access_key_name` + `s3_secret_key_name`
  (or `s3_key_name` when `key_aws` is enabled).
- This module stores **no credentials** — it reads Key entities via `key.repository` at runtime.
- Upload `putObject()`, list `ListObjects` iterator, fetch `getObject()`, delete `deleteObject()`,
  all scoped to bucket + prefix.
- Route subscriber overrides `entity.backup_migrate_destination.backup_download` to this module's
  controller; access is still Backup & Migrate's.
