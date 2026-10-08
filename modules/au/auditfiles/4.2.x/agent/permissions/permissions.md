<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Two permissions (`auditfiles.permissions.yml`):

| Permission | Machine name | Gates | restrict access |
|---|---|---|---|
| Access Audit Files reports | `access audit files reports` | Viewing and running all seven reports under `/admin/reports/auditfiles/…` | no |
| Configure Audit Files module | `configure audit files reports` | The settings form at `/admin/config/system/auditfiles` (route `auditfiles.configuration`) | yes |

Notes:

- `configure audit files reports` is marked `restrict access: TRUE` (a security-sensitive
  permission) — grant it only to trusted administrators, since the reports can delete files and
  database records.
- The report routes require only `access audit files reports`, but the fix actions on those
  reports permanently delete files/records, so treat that permission as sensitive too.

```bash
drush role:perm:add site_maintainer 'access audit files reports'
drush role:perm:add administrator 'configure audit files reports'
```
