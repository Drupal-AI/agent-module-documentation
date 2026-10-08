<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

The module defines a single permission (`file_upload_secure_validator.permissions.yml`).

| Permission machine name | Title | Gates | Notes |
|---|---|---|---|
| `administer file upload secure validator configuration` | Administer File Upload Secure Validator configuration | Access to the settings form / route `file_upload_secure_validator.file-upload-secure-validator-settings` (`/admin/config/media/file_upload_secure_validator`) | `restrict access: TRUE` — flagged as security-sensitive; grant only to trusted admin roles. |

Grant with Drush:

```bash
drush role:perm:add administrator 'administer file upload secure validator configuration'
```

The upload-time validation itself is **not** permission-gated: it runs for every user and
every file upload via the `FileValidationEvent` subscriber. This permission only controls
who may edit the MIME type equivalence groups.
