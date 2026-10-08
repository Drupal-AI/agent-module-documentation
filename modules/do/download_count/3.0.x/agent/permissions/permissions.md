<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Declared in `download_count.permissions.yml`:

| Permission | Used by | Effect |
|---|---|---|
| `view download counts` | routes `download_count.reports`, `.details`, `.reset`, `.export`; field formatter `FieldDownloadCount` | Access the admin download-count report/details/reset/export pages, and see the per-file count rendered by the field formatter. |
| `skip download counts` | `_download_count_track_file_download()` in `download_count.module` | A user with this permission is **not** counted (their download is logged to watchdog but no counter row is inserted). Assign to staff/admin roles and crawlers to keep internal traffic out of the figures. |
| `reset download counts` | declared only | Intended to gate counter resets. |
| `export download counts` | declared only | Intended to gate CSV exports. |

## Block access permissions (not declared in permissions.yml)
The two blocks gate themselves with `AccessResult::allowedIfHasPermission()` on permission
strings that the module does **not** declare, so they must be granted by another module or
treated as never-granted:

| Block plugin | `blockAccess` permission |
|---|---|
| `top_download` (`TopDownload`) | `access top download` |
| `recent_download` (`RecentDownload`) | `access recent download` |

## Report/details/reset/export routes
All four report routes (`download_count.reports`, `.details`, `.reset`, `.export`) require
`view download counts`. The settings and cache-clear routes (`download_count.file_settings`,
`download_count.clear`) require `administer site configuration`.

## Grant examples
```bash
ddev drush role:perm:add editor 'view download counts'
ddev drush role:perm:add administrator 'skip download counts'
```
