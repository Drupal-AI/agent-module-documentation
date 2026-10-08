# Configuration

Grant Plus has a single setting, and it lives on the **S3 File System** settings
form rather than on a page of its own.

## Before you start

1. Configure and enable **s3fs** with your AWS credentials and bucket.
2. Enable **s3fs_grant_plus**.
3. Have the **canonical user ID** of the AWS account that should receive read-only
   access ready. This is the AWS *canonical user ID*, not an account number or an
   IAM user name.

## Set the reader account ID

Go to **Configuration → Media → S3 File System** (`/admin/config/media/s3fs`,
permission **Administer S3 File System**). Grant Plus adds a field labelled
along the lines of **ID of the user granted read access** — enter the canonical
user ID there and save.

There are two ways to provide the value:

- **Through the form (config):** the value is stored in the module's own
  configuration, `s3fs_grant_plus.settings`. (A minor curiosity: the underlying
  config key is spelled `grand_read_id` — a typo in the module — but you never need
  to touch it directly; the form handles it.)
- **In `settings.php` (override):** define
  `$settings['s3fs.grant_read_user_id'] = '<canonical-user-id>';`. When this is
  present it takes precedence, and the form field is shown but disabled. This is
  handy for setting a different reader account per environment without editing
  configuration.

## What it does

Once set, every file s3fs **uploads** (via `hook_s3fs_upload_params_alter`) or
**copies** (via `hook_s3fs_copy_params_alter`) gets `GrantRead => id=<value>` added
to its S3 parameters. That is an object-level ACL granting read access to the one
named account — it is **not** a public-read grant, and it does not change Drupal's
own file access. Files that existed before you configured the grant are not
retroactively updated; only new uploads and copies carry it.

## Remember the image-style caveat

Because the reader account has read-only access, front-end consumers using that
account cannot generate image-style derivatives on the fly (that needs a write).
Pre-generate your image styles at upload time instead — the module's docs suggest
the **Image Style Warmer** module for this.
