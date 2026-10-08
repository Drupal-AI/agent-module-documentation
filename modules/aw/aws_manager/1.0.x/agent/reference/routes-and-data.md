<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS Manager — routes, forms & data model

## Routes (`aws_manager.routing.yml`)
All routes require `_permission: 'access aws manager'` (restricted). No anonymous or lower-privilege routes exist.

| Route | Path | Form (src/Form/) | AWS SDK calls |
|-------|------|------------------|---------------|
| `aws_manager.aws_credentials_form` | `/admin/aws/credentials` | `AwsCredentialsForm` | `S3::listBuckets` (test) |
| `aws_manager.client_manage_form` | `/admin/aws/client` | `ClientManageForm` | `Organizations::createAccount`, `describeCreateAccountStatus`; `S3::createBucket`, `waitUntil` |
| `aws_manager.aws_live_list` | `/admin/aws/live-list` | `AwsLiveClientListForm` | `Organizations::listAccounts`, `S3::listBuckets` |
| `aws_manager.account_view` | `/admin/aws/account/view/{account_id}` | `AwsAccountViewForm` | `Organizations::describeAccount`, `S3::listBuckets` |
| `aws_manager.account_delete` | `/admin/aws/account/delete/{account_id}` | `AwsAccountDeleteForm` (ConfirmForm) | `STS::getCallerIdentity`, `Organizations::leaveOrganization` / `removeAccountFromOrganization` |
| `aws_manager.s3_file_upload_form` | `/admin/aws/upload-file/{bucket}` | `S3FileUploadForm` | `S3::doesBucketExist`, `createBucket`, `putObject` |
| `aws_manager.s3_bucket_files` | `/admin/aws/s3/{bucket_name}/browse` | `S3BucketFileBrowserForm` | `S3::listObjectsV2`, `createPresignedRequest` |
| `aws_manager.s3_file_edit_modal` | `/admin/aws/s3/{bucket}/edit/{key}` | `S3FileEditForm` | `S3::createPresignedRequest`, `putObject` |
| `aws_manager.s3_file_delete` | `/admin/aws/s3/{bucket}/delete/{key}` | `S3FileDeleteConfirmForm` (ConfirmForm) | `S3::deleteObject` |
| `aws_manager.s3_bucket_delete` | `/admin/aws/s3/delete/{bucket_name}` | `DeleteS3BucketForm` | `S3::listObjectsV2`, `deleteObject`, `deleteBucket` |

State-changing operations run through Drupal form submit/AJAX (POST, form token). `account_delete` and `s3_file_delete` are `ConfirmFormBase`. Region is hard-coded `us-east-1`.

## Permission (`aws_manager.permissions.yml`)
- `access aws manager` — title "Access AWS Manager", `restrict access: TRUE`.

## Menu (`aws_manager.links.menu.yml`)
Parent `aws_manager.admin_menu` under `system.admin_config` → child links: AWS Credentials, Manage AWS Clients, Live AWS Accounts & Buckets. Detail/upload/delete routes are not in the menu (reached via table actions/modals).

## Database tables (`aws_manager.install` `hook_schema`)
No config schema; the module owns these tables:

- **`aws_credentials`** — `id` (serial PK), `access_key`, `secret_key`, `uid`. One row per Drupal user; the live credential store read by every form.
- **`aws_organisation`** — `aws_org_id` (PK), `username`, `password`, `api_key`, `api_secret`, `uid`. Upserted by credential save and client creation.
- **`aws_client_accounts`** — `aws_client_acccount_id` (PK; note misspelling), `aws_organisation` (FK), `uid`, `type`, `password`, `api_key`, `api_secret`.
- **`aws_clients`** — `id` (PK), `client_name`, `original_bucket_input`, `bucket_name`, `bucket_url`, `region`, `iam_role_name`, `created_by_uid`, `upload_permission`, `aws_account_id`, `uid`, `created`. (Declared in schema; written by delete cleanup, largely bookkeeping.)
- **`aws_folders`** — `aws_folder_id` (PK), `uid`, `module_name`, `added_by_uid`, `path`.
- **`aws_files`** — `file_id` (PK), `uid`, `fid`, `file_name`, `file_type`, `alt_tag`, `main_image`, `uploaded_by`, `date_uploaded`, `file_size`, `aws_folder_id` (FK), `module_entity_id`, `status`, `flag`. Upload metadata.

All queries use the Drupal DB API (`select/merge/insert/update/delete` with `->condition()` placeholders) — no raw string-concatenated SQL.

## Library (`aws_manager.libraries.yml`)
`aws_ui`: `css/aws-ui.css` plus core deps (`jquery`, `drupal`, `drupal.ajax`, `drupal.dialog`, `drupal.dialog.ajax`, `drupal.messages`, `jquery.ui`). Attached by the forms for the modal/tab UI.
