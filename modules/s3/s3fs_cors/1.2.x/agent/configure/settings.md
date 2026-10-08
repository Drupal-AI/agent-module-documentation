# Configure S3 File System CORS Upload

## Prerequisites

`s3fs` must already be configured (bucket, region, credentials in `s3fs.settings`, or credentials
via IAM instance profile / `settings.php`). This module reuses all of that; it adds only the
CORS-specific bits.

## Admin form — `/admin/config/media/s3fs/cors`

Route `s3fs_cors.admin_form` (`S3fsCorsAdminForm`, permission `administer s3fs CORS`). Writes config
object `s3fs_cors.settings`:

| Key | Default | Meaning |
|---|---|---|
| `s3fs_cors_origin` | `''` | Origin(s) allowed to POST to the bucket; comma/space list, one `*` wildcard allowed (e.g. `*.example.com`). |
| `s3fs_https` | `http` | Scheme used for the direct-upload POST endpoint (`http` / `https`). |
| `s3fs_access_type` | `public-read` | ACL applied to uploaded objects (`public-read` / `private`). |
| `s3fs_sts_policy_resource` | `''` | Resource ARN used in the STS federation-token policy (fallback credential path). |

**On save the form talks to AWS directly:** if an origin is set it calls `putBucketCors()` building
CORS rules that allow `POST` from `http://` and `https://` of each origin (plus a wildcard `GET`
rule); if the origin field is cleared it calls `deleteBucketCors()` to remove the bucket's CORS
config. So this form mutates real bucket configuration, not just Drupal config.

## Field widgets

Set a field's widget on **Manage form display** to one of:

| Widget id | For | Notes |
|---|---|---|
| `s3fs_cors_file_widget` | file fields | extends core file widget; adds `max_filesize` setting. |
| `s3fs_cors_image_widget` | image fields | extends core image widget; adds `max_filesize` setting. |

The field's **upload destination** (e.g. `s3://…`, `public://`, `private://`) determines the S3
object key; public/private schemes are mapped to the configured `s3fs` public/private folders and
any `root_folder` prefix is prepended.

## ACL and credentials

- Uploaded objects get the `s3fs_access_type` ACL. Use `private` if files must not be world-readable
  (public-read makes the object publicly fetchable by URL).
- Credentials for signing come from `s3fs.settings` (`access_key`/`secret_key`) or the default AWS
  provider chain; when the client has no static keys/session token the element requests an STS
  `getFederationToken` session scoped to `s3fs_sts_policy_resource`.
