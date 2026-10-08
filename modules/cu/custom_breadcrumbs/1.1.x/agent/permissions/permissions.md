<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One permission (`custom_breadcrumbs.permissions.yml`):

| Permission | Machine name | Gates |
|---|---|---|
| Administer custom breadcrumbs | `administer custom_breadcrumbs` | The global settings form (`custom_breadcrumbs.config`) and all breadcrumb-entity routes: collection, add, edit, delete, and status forms under `/admin/structure/custom-breadcrumbs`. |

It is also the config entity's `admin_permission`, so it governs every operation on
`custom_breadcrumbs` entities.

```bash
drush role:perm:add site_builder 'administer custom_breadcrumbs'
```
