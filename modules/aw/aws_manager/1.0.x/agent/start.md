<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS Manager (aws_manager) — agent index

Drupal admin UI that stores **per-user AWS credentials** and manages **S3 buckets/files** and **AWS Organization accounts** via the official `aws/aws-sdk-php` SDK. All routes are under `/admin/aws/*`, gated by one restricted permission `access aws manager`. Core `^10 || ^11 || ^12`; version dir `1.0.x` (installed 1.0.0).

## Requirements / dependencies
- Composer: `aws/aws-sdk-php: ^3.0` (must be installed before enabling).
- No Drupal module dependencies declared in `.info.yml`; uses core `file` entity for uploads.
- No config entities, no config/schema, no plugins, no Drush commands.

## What it provides
- **Permission:** `access aws manager` (`aws_manager.permissions.yml`, `restrict access: TRUE`).
- **DB tables** (`aws_manager.install` `hook_schema`): `aws_credentials`, `aws_organisation`, `aws_client_accounts`, `aws_clients`, `aws_folders`, `aws_files`. (No config storage — credentials live in `aws_credentials`.)
- **10 form routes** (`aws_manager.routing.yml`), all `_permission: 'access aws manager'` — see `agent/reference/routes-and-data.md`.
- **Menu:** Configuration → AWS Manager (`aws_manager.links.menu.yml`).
- **Library:** `aws_manager/aws_ui` (CSS + core AJAX/dialog deps) for modal UI.
- **Hook:** `hook_aws_manager_upload_file_alter(array &$record, FileInterface $file)` (documented in `README.md`/`hook_help`).

## Forms (src/Form/)
- `AwsCredentialsForm` — save Access Key ID + Secret; "Test Connection" (`S3::listBuckets`).
- `ClientManageForm` — create S3 bucket, optionally create an AWS Organizations account.
- `AwsLiveClientListForm` — live dashboard: Organization accounts + S3 buckets tabs.
- `AwsAccountViewForm` / `AwsAccountDeleteForm` — view / remove-or-leave an Org account (STS decides).
- `S3BucketFileBrowserForm` — list objects (Images/Documents/Others tabs), presigned links.
- `S3FileUploadForm` — `managed_file` AJAX upload to S3, records `aws_files`.
- `S3FileEditForm` — overwrite an object; `S3FileDeleteConfirmForm` — delete object; `DeleteS3BucketForm` — empty + delete bucket.

## Solution docs
- `agent/config/credentials.md` — install, credential storage, connecting to AWS, operating the UI.
- `agent/reference/routes-and-data.md` — every route + access, the AWS SDK calls, DB tables.

## Notes for agents
- AWS region is hard-coded `us-east-1` for the SDK clients (the file browser re-derives region from an `AuthorizationHeaderMalformed` error).
- Credentials are read by `\Drupal::currentUser()->id()`; each admin uses their own keys.
- AWS keys are secrets — provision via least-privilege IAM; never commit them.
