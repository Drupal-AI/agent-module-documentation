<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `content_synchronizer.permissions.yml`. Separate permissions gate the dashboard and the two
entity types.

| Permission | Gates |
|---|---|
| `access content synchronizer dashboard` | The dashboard and export/download routes (`/admin/content_synchronizer`, export confirm, quick export, download archive). |
| `add import entities` | Create new Import entities. |
| `administer import entities` | Import entity admin/config form. **restrict access: true.** |
| `delete import entities` | Delete Import entities. |
| `edit import entities` | Edit Import entities. |
| `access import overview` | The Import collection/overview page. |
| `view published import entities` | View published Import entities. |
| `view unpublished import entities` | View unpublished Import entities. |
| `add export entity entities` | Create new Export entities. |
| `administer export entity entities` | Export entity admin/config form. **restrict access: true.** |
| `delete export entity entities` | Delete Export entities. |
| `edit export entity entities` | Edit Export entities. |
| `access export entity overview` | The Export collection/overview page. |
| `view published export entity entities` | View published Export entities. |
| `view unpublished export entity entities` | View unpublished Export entities. |

The two `administer …` permissions are the `admin_permission` of their entity types
(`administer import entities`, `administer export entity entities`) and are flagged
security-sensitive. Grant, e.g.:
`drush role:perm:add editor 'access content synchronizer dashboard'`.
