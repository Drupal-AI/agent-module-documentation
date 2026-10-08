<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring S3 DB Export

## Requirements
Composer libs are required: `ifsnop/mysqldump-php:^2` and `aws/aws-sdk-php:^3`.

## Settings
At `/admin/config/content/DbForm` (permission `administer Dbexport settings` + role `administrator`) set:
- Enable S3 storage checkbox, AWS region, version, key, secret, bucket, bucket folder.
- Values are saved via the `state` service (keys: `enable_s3_service`, `aws_region`, `aws_version`, `aws_key`, `aws_secret`, `aws_bucket`, `aws_bucket_folder`).

## Triggering
- Visit `/db-export-s3` to dump + (if enabled) upload to S3.
- Visit `/db-export-s3-download` to stream the freshly created SQL file.
- `hook_cron` / the bundled Ultimate Cron job (`Dbexport_cron_job1`, every minute) can drive exports.

## How it works (`DbexportManager`)
- `dump()` writes `public://tmp/backup_<time><rand>.sql` via mysqldump-php.
- `awss3()` constructs an `S3Client` from the stored credentials and `putObject`s the file.

## Hardening notes for operators
- The dump lands in the public files dir and is never removed — serve it from a private stream and delete after upload.
- Store AWS credentials with the Key module rather than `state`.
- The `configure` link in info.yml (`s3_db_export.admin_config_form`) does not match the real route id (`s3_db_export.admin_settings`).
