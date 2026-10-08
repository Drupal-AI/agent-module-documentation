<!--
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Permissions

Defined in `publication_date.permissions.yml` plus a dynamic callback
(`PublicationDateNodePermissions::nodeTypePermissions`) that generates two permissions per
content type.

## Global permissions
| Permission | Grants |
|---|---|
| `administer publication date` | Full edit access to the "Published on" date on any node (highest priority). |
| `set any published on date` | Edit the "Published on" date for **any** content type. |
| `view any published on date` | See (read-only) the "Published on" date for **any** content type. |

## Per-content-type permissions (generated)
For every content type `{type}` (machine name), two permissions exist:
| Permission | Grants |
|---|---|
| `set {type} published on date` | Edit the date for that content type (e.g. `set article published on date`). |
| `view {type} published on date` | View (read-only) the date for that content type. |

## How access resolves on the node form
Evaluated in `hook_form_node_form_alter()`:
- **Can edit** if `administer publication date` OR `set any published on date` OR
  `set {bundle} published on date` → widget editable.
- Else **can view** if `view any published on date` OR `view {bundle} published on date` →
  widget shown but disabled (read-only).
- Else the widget is hidden entirely.

Grant with drush, e.g.:
```bash
drush role:perm:add editor 'set any published on date'
drush role:perm:add editor 'set article published on date'
```
