<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions (`meaofd.permissions.yml`)

Both are marked `restrict access: true` (they appear with a security warning on the permissions page).

| Machine name | Gates |
|---|---|
| `view mismatched entity and or field definitions` | The report page route `meaofd.report` (`/admin/reports/mismatched-entity-and-or-field-definitions`). Users without it cannot see the report. |
| `fix mismatched entity and or field definitions` | The confirm/fix route `meaofd.fix`. Without it the report still renders but each entity type's action is a **disabled** "Fix" span instead of a working link. |

Grant with Drush:

```bash
drush role:perm:add auditor 'view mismatched entity and or field definitions'
drush role:perm:add site_admin 'fix mismatched entity and or field definitions'
```

Read back a role's granted permissions:

```bash
drush config:get user.role.site_admin permissions
```

There are no other permissions; the Drush command and the `meaofd.fixer` service are not permission-gated
(the Drush command runs as the CLI user).
