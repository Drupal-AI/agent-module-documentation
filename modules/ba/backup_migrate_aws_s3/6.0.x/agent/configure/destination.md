<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure an AWS S3 destination

This module has no settings page of its own; you add an S3 **destination** inside Backup &
Migrate. The destination field schema is defined by `AWSS3Destination::configSchema()`.

## Prerequisites

1. Enable `backup_migrate`, `key`, and this module (all installed via Composer, which also pulls
   `aws/aws-sdk-php`).
2. Create Key entities at `/admin/config/system/keys` for your AWS credentials:
   - one key holding the **access key id**, one holding the **secret access key**, or
   - (if the optional `key_aws` module is installed) a single AWS **credentials-file** key.

## Add the destination

1. Go to *Backup & Migrate → Settings → Destinations*
   (`/admin/config/development/backup_migrate/settings/destination`).
2. *Add destination* and choose type **AWS S3**.
3. Fill the fields:

| Field | Key | Required | Notes |
|---|---|---|---|
| S3 Endpoint/Host | `s3_endpoint` | no | e.g. `https://s3.amazonaws.com`. Set a custom endpoint for S3-compatible storage (MinIO, Wasabi, Spaces). |
| S3 Access Key | `s3_access_key_name` | no* | Key entity holding the access key id (shown when `key_aws` is **not** enabled). |
| S3 Secret Key | `s3_secret_key_name` | no* | Key entity holding the secret key (shown when `key_aws` is **not** enabled). |
| S3 Credentials Key | `s3_key_name` | no* | Single AWS credentials-file key (shown only when `key_aws` **is** enabled). |
| S3 Bucket | `s3_bucket` | **yes** | Target bucket name. |
| Sub-folder | `s3_folder_prefix` | no | Prefix without leading/trailing slashes, e.g. `my/subfolder`. Changing it hides earlier backups stored under a different prefix (they remain in the bucket). |
| S3 Region | `s3_region` | **yes** | One of the standard AWS region ids (enum). |

\* The credential fields are individually optional in the schema, but a working client needs a
region **and** resolvable key+secret (or a credentials-file key). Without them the client falls
back to the AWS SDK's default provider chain; if nothing resolves you'll get "Please fill all
mandatory fields to create S3 client."

4. Save. You can now select this destination for manual (Quick Backup) or scheduled backups.

## Notes

- The module does not persist credentials — only the **names** of Key entities are stored in the
  destination config; values are read at runtime via `key.repository` (or `key_aws.repository`).
- Rotate credentials by editing the referenced Key entity; no destination change needed.
- Restrict the IAM user/role to just the backup bucket for least privilege.
