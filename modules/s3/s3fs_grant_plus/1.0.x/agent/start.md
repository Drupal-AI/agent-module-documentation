<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# S3 File System Grant Plus (s3fs_grant_plus) — agent index

**Injects an S3 `GrantRead` ACL for a second AWS account into s3fs upload/copy operations.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Dependency:** s3fs.
- **No routes/controllers.** Implements `hook_s3fs_upload_params_alter()`, `hook_s3fs_copy_params_alter()`, and alters `s3fs_admin_settings_form` (configure route `s3fs.admin_settings`).
- **Grant source:** `Settings::get('s3fs.grant_read_user_id')` (disables the form field when set) else config `s3fs_grant_plus.settings:grand_read_id`.
- **Security:** the grant is an S3 object ACL to a specific AWS canonical user ID — it does **not** make files public and does not alter Drupal file access. Configured only via the s3fs admin form (`administer s3fs`). No anonymous endpoints, no outbound HTTP, no stored secrets.

See [configure/grant.md](configure/grant.md)
