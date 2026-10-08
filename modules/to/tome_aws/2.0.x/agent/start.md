<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome AWS - agent index

Deploys a **Tome static build to Amazon S3** (upload + redirects + metadata diff). Version **2.0.2**, core `^8 || ^9 || ^10`.

- Config object `tome_aws.settings`: `aws_s3_client_id`, `aws_s3_client_secret`, `aws_s3_bucket_name`, `aws_s3_bucket_prefix`, `aws_s3_region`, `aws_s3_acl`.
- Settings form route `tome_aws.settings`, deploy route `tome_aws.deploy`; both require permission `use tome static`.
- Depends on `tome_static`; uses `aws/aws-sdk-php` `S3Client` (TLS on by default).
- Drush `Deploy` command wired via `drush.services.yml`.
- NOTE: S3 secret is stored in plaintext config (no Key entity).