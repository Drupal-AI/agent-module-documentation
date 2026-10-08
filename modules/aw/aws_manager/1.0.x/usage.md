AWS Manager is a Drupal admin UI for storing per-user AWS credentials and managing S3 buckets/files plus AWS Organization accounts through the official AWS PHP SDK.

---

AWS Manager adds a Configuration → AWS Manager admin section where each Drupal user saves their own AWS Access Key ID and Secret Access Key (persisted in custom database tables, not Drupal config). With those keys the module talks to Amazon S3, AWS Organizations and STS from ordinary Drupal forms: it lists buckets, creates and deletes buckets, lists/uploads/replaces/deletes S3 objects (with presigned download links and files grouped into Images/Documents/Others tabs), and lists, views, creates and removes AWS Organization member accounts. Every route lives under `/admin/aws/*` and is protected by one restricted permission, `access aws manager`. The module requires `aws/aws-sdk-php` via Composer, ships no config entities or plugins, and provides an AJAX/modal UI (the `aws_ui` CSS/JS library). It is best treated as an administrator-only cloud-operations dashboard.

---

- Give trusted administrators a per-user place to store an AWS Access Key ID + Secret Access Key inside Drupal (`/admin/aws/credentials`).
- Use the "Test Connection" button to verify a key pair by calling `S3::listBuckets()` before saving.
- View a live dashboard of AWS Organization accounts and S3 buckets in one tabbed screen (`/admin/aws/live-list`).
- List all S3 buckets visible to the stored credentials, with creation date and public S3 URL.
- Create a new S3 bucket (name validated to S3 naming rules) from the "Manage AWS Clients" form.
- Optionally create a brand-new AWS Organization member account (name + email) alongside the bucket via `OrganizationsClient::createAccount()`.
- Delete an entire S3 bucket, emptying its objects first, through an AJAX confirm modal.
- Browse the objects in a bucket, automatically grouped into Images, Documents and Others tabs (`/admin/aws/s3/{bucket}/browse`).
- Generate short-lived (10-minute) presigned download URLs for S3 objects, with inline image previews.
- Upload one or more files into an S3 bucket via a `managed_file` AJAX form (`/admin/aws/upload-file/{bucket}`), tracking metadata in the `aws_files` table.
- Replace (overwrite) an existing S3 object with a new upload through the edit modal (`/admin/aws/s3/{bucket}/edit/{key}`).
- Delete an individual S3 object with an AJAX confirm form (`/admin/aws/s3/{bucket}/delete/{key}`).
- View full details of an AWS Organization account (ID, name, root email, status, joined date) in a modal (`/admin/aws/account/view/{account_id}`).
- Remove or leave an AWS Organization member account, with STS `getCallerIdentity()` deciding `leaveOrganization()` vs `removeAccountFromOrganization()` (`/admin/aws/account/delete/{account_id}`).
- Restrict all cloud-operation tooling behind the single `access aws manager` permission granted only to admin/editorial roles.
- Provide a maintenance UI for cleaning up local bookkeeping tables (`aws_clients`, `aws_folders`, `aws_files`) when an account is removed.
- Alter file metadata before it is recorded, using the documented `hook_aws_manager_upload_file_alter()` integration hook.
- Support multi-admin setups where each administrator uses their own scoped IAM keys rather than a shared site-wide credential.
- Serve as a starting point/reference for building a Drupal-hosted S3 file manager or AWS Organizations console.
- Harden staging/test environments by pairing the module's routes with the Shield or IP-restriction modules.
- Categorize uploaded assets automatically by extension (jpg/png/gif/webp as images; pdf/doc/xls/ppt/txt/csv as documents; everything else as "other").
