<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`advban.permissions.yml` defines exactly one permission:

| Machine name | Title |
|---|---|
| `advanced ban IP addresses` | Ban IP addresses |

It is the `_permission` requirement on **every** advban route (`advban.admin_page`,
`advban.search`, `advban.edit`, `advban.delete`, `advban.delete_all`, `advban.settings`), so
it gates viewing the ban list, adding/editing/deleting bans, bulk deletion **and** the
settings form. There is no separate "administer" vs "view" split.

```bash
drush role:perm:add support_team 'advanced ban IP addresses'
drush role:perm:list support_team | grep advban
```

Note: the ban itself is enforced by an HTTP middleware and is **not** permission-based — a
banned IP gets a 403 before routing, regardless of who is logged in from it.
