<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS Manager — install, credentials & operation

## Install / enable
1. `composer require aws/aws-sdk-php:^3.0` (the module has no bundled SDK; enabling without it fatals on the `Aws\*` classes).
2. `drush en aws_manager` (or via UI). `hook_schema` in `aws_manager.install` creates the tables below.
3. Grant `access aws manager` to trusted admin roles only (`aws_manager.permissions.yml`, `restrict access: TRUE`).

There is **no settings/config form** and no `config/*` — `data.json` `configure` is null and `provides_config_schema` is false. All state is in custom DB tables, not Drupal configuration.

## Credentials
`AwsCredentialsForm` (`/admin/aws/credentials`, `getFormId() = aws_credentials_form`):
- Two text fields: `access_key` (Access Key ID) and `secret_key` (Secret Access Key).
- **Test Connection** (`testConnectionSubmit`): builds an `S3Client` (region `us-east-1`) and calls `listBuckets()` to validate the pair; result shown via messenger. AJAX only, does not save.
- **Save** (`submitForm`): `merge()` into `aws_credentials` keyed on `uid`, and upsert into `aws_organisation` (username `user_<uid>`). Keys are keyed to `\Drupal::currentUser()->id()` — each user stores/uses their own pair.

Other forms all begin by loading the current user's row from `aws_credentials`; if none exists they render a "Set credentials" error and stop.

## Connecting to AWS
Every form instantiates SDK clients inline with the loaded key/secret and **region hard-coded `us-east-1`**:
- `Aws\S3\S3Client` — bucket/object operations.
- `Aws\Organizations\OrganizationsClient` — Organization account operations.
- `Aws\Sts\StsClient` — `getCallerIdentity()` in `AwsAccountDeleteForm` to choose leave vs remove.
- `S3BucketFileBrowserForm` retries with the region parsed out of an `AuthorizationHeaderMalformed` AWS error message when the bucket lives elsewhere.

TLS verification is the AWS SDK default (enabled).

## Operating the UI (menu: Configuration → AWS Manager)
- **AWS Credentials** → `aws_manager.aws_credentials_form`.
- **Manage AWS Clients** → `ClientManageForm` (`/admin/aws/client`): required `bucket_name` (validated by `validateBucketName`: `^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$`); bucket name is lowercased and suffixed with `time()`. Optional `create_account` checkbox → `OrganizationsClient::createAccount()` (name/email), `sleep(10)`, then `describeCreateAccountStatus()`. Then `S3::createBucket` + `waitUntil('BucketExists')`, and inserts into `aws_organisation`, `aws_client_accounts`, `aws_folders`.
- **Live AWS Accounts & Buckets** → `AwsLiveClientListForm` (`/admin/aws/live-list`): `OrganizationsClient::listAccounts()` + `S3::listBuckets()` rendered as vertical tabs with View/Delete/Browse/Upload actions.

## Uploads & file model
`S3FileUploadForm` (`/admin/aws/upload-file/{bucket}`): core `managed_file` (`public://`, multiple), AJAX submit `putObject` (ACL `private`) per file, records metadata in `aws_files`. `S3FileEditForm` overwrites an object (`putObject` same key). `S3FileDeleteConfirmForm` / `DeleteS3BucketForm` delete an object / empty+delete a bucket. `S3BucketFileBrowserForm` groups objects into Images / Documents / Others and builds 10-minute presigned GET URLs.

`hook_aws_manager_upload_file_alter(array &$record, \Drupal\file\FileInterface $file)` is documented for altering the upload record before it is saved.
