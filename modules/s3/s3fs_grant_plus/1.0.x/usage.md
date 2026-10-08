<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
S3 File System Grant Plus extends the s3fs module so that files it uploads or copies to Amazon S3 also carry a `GrantRead` ACL for a second AWS canonical user ID, giving that account read-only access to the objects.
---
The module has no routes or controllers. It implements `hook_s3fs_upload_params_alter()` and `hook_s3fs_copy_params_alter()` to inject `GrantRead => 'id=<canonical-user-id>'` into the S3 request parameters, and a `hook_form_FORM_ID_alter()` that adds a "grant read ID" field to the s3fs admin settings form (`s3fs.admin_settings`). The grant ID is read from Drupal `Settings::get('s3fs.grant_read_user_id')` if present (in which case the form field is disabled), otherwise from the module's own config `s3fs_grant_plus.settings:grand_read_id`. The typical use case (from the README) is a microservice/back-office split where an administrator app writes files and front-end consumers get read-only access via the second account.

Security-wise this is an object-level S3 ACL grant to a specific AWS account identified by its canonical user ID — it does not make files public and does not change Drupal's own file access. The value is configured on the s3fs admin form, which is protected by s3fs's `administer s3fs` permission. There are no anonymous endpoints, no external HTTP calls, and no secrets stored by this module. Setup: configure s3fs, then enter the reader account's canonical ID (or define it in settings.php).
---
- Grant a second AWS account read-only access to uploaded files
- Apply the same read grant to files copied within s3fs
- Split file creation (admin app) from file consumption (front-end)
- Configure the reader account ID on the s3fs settings form
- Lock the grant ID in `settings.php` so it cannot be edited in the UI
- Keep front-end users at read-only permissions on S3 objects
- Support microservice architectures sharing one S3 bucket
- Add `GrantRead` ACLs without patching the s3fs module
- Enforce least-privilege object access across accounts
- Use the module's own config when no settings.php value is set
- Avoid making private files public while still sharing them
- Integrate with an external back-office that owns writes
- Provide image/video/audio read access to a partner account
- Manage cross-account S3 access declaratively
- Disable the UI field by defining the settings.php override
- Pair with Image Style Warmer to pre-generate styles (README tip)
- Audit which account receives read grants via config
- Roll the grant ID differently per environment via settings.php
- Keep the grant scoped to newly created/copied objects
- Document cross-account access as part of the s3fs config
