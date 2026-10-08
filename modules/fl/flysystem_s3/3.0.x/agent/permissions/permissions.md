<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One permission, defined in `flysystem_s3.permissions.yml`.

| Permission | Machine name | Gates |
|---|---|---|
| Upload files directly to S3 using CORS | `use S3 CORS upload` | Access to the two POST endpoints `/flysystem-s3/cors-upload-sign` and `/flysystem-s3/cors-upload-save`, AND whether the CORS-upload behavior is attached to a `managed_file` element (checked in `S3CorsManagedFileHelper::isCorsAvailable()`). |

Grant it (drush):

```bash
drush role:perm:add editor 'use S3 CORS upload'
drush role:perm:remove editor 'use S3 CORS upload'
drush user:role:add editor someuser
```

Notes:
- CORS upload only actually activates when the scheme also has `config.cors: TRUE` and the
  bucket allows CORS — the permission alone does nothing without the S3 scheme configured.
- The sign endpoint returns a presigned S3 policy scoped to the destination key and
  content-type; treat this permission as a trusted capability (it lets a user obtain signed
  write access to the configured bucket path and register File entities).
- Everything else (defining schemes, choosing default file storage) is done in settings.php and
  core file-system config, not via a flysystem_s3 permission.
