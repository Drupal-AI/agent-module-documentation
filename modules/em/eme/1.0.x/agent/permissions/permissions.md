<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `eme.permissions.yml`. Both are flagged `restrict access: TRUE`.

| Permission | Grants | Guards routes |
|---|---|---|
| `export content` | Run exports and download the generated migration set. | `eme.eme_export_form`, `eme.collection`, `eme.eme_export_download`, `eme.eme_export_download_file` |
| `manage content export settings` | Edit the `eme.settings` defaults. | `eme.settings` |

## Enforcement points

- Every route requirement uses `_permission` (see the route table in
  `../start.md`).
- `eme.eme_export_download_file` additionally requires the custom
  `_export_exists: 'TRUE'` check (`access_check.export_exists` →
  `Access\DownloadAccessCheck`), which allows the route only while the tarball
  `temporary://eme.tar.gz` exists.
- `hook_file_download()` in `eme.module` re-checks `export content` before
  returning the `Content-disposition` header for that temporary archive; without
  the permission it returns `-1` (deny).

## Grant via Drush

```bash
drush role:perm:add site_admin 'export content'
drush role:perm:add site_admin 'manage content export settings'
```
