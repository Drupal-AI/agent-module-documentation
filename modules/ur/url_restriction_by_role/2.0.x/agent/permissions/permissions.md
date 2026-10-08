<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One permission (`url_restriction_by_role.permissions.yml`):

| Permission | `restrict access` | Gates |
|---|---|---|
| `admin url restriction by role settings` | `true` | Access to the settings form (`/admin/config/search/path/url-restriction-by-role`) — i.e. defining which URLs are restricted, to which roles, and the error message. |

`restrict access: true` marks it as a trusted/administrative permission (Drupal warns when granting it),
so it should only go to fully trusted administrators. The module defines **no** end-user permission —
who may *view* a restricted URL is decided entirely by the per-URL "Allowed Roles" config, not by a
Drupal permission.
