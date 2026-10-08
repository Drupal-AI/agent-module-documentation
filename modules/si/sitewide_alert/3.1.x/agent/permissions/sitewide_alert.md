<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sitewide Alert — permissions

From `sitewide_alert.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer sitewide alert` | The global settings form `/admin/config/sitewide_alerts` (styles, refresh, etc.). *restrict access.* |
| `administer sitewide alert entities` | Full admin access to configure alert entities. *restrict access.* |
| `add sitewide alert entities` | Create new alerts. |
| `edit sitewide alert entities` | Edit existing alerts. |
| `delete sitewide alert entities` | Delete alerts. |
| `view published sitewide alert entities` | See **active** alerts — grant to every role that should see banners (also gates the `/sitewide_alert/load` JSON endpoint). |
| `view unpublished sitewide alert entities` | See inactive alerts. |
| `view all sitewide alert revisions` | View the revision history. |
| `revert all sitewide alert revisions` | Revert to an earlier revision. |
| `delete all sitewide alert revisions` | Delete revisions. |

Typical setup: give anonymous + authenticated `view published sitewide alert
entities` so visitors see banners; give an editor role `add/edit/delete sitewide
alert entities` to manage alerts without full site admin. Keep `administer
sitewide alert` (global config) to administrators.
