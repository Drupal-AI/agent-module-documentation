<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the S3 read grant

1. Configure and enable **s3fs** with your AWS credentials and bucket.
2. Enable `s3fs_grant_plus`.
3. On the s3fs settings form (`/admin/config/media/s3fs`, permission `administer s3fs`) enter **ID of the user granted read access** — the AWS **canonical user ID** of the account that should get read-only access.

Two ways to set the value:
- **UI/config:** the value is stored in `s3fs_grant_plus.settings:grand_read_id` (note the `grand`/`grant` typo in the config key).
- **settings.php override:** define `$settings['s3fs.grant_read_user_id']`. When present it takes precedence and the UI field is shown disabled.

Effect: every upload (`hook_s3fs_upload_params_alter`) and copy (`hook_s3fs_copy_params_alter`) adds `GrantRead => id=<value>` to the S3 params. This is an object-level ACL to one named account — it is not a public-read grant. Files created before configuration are unaffected. Note the README caveat that read-only front-end users cannot generate image styles on the fly, so pre-warm styles (e.g. Image Style Warmer).
