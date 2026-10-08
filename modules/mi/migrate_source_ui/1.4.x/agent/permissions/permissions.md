<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `migrate_source_ui.permissions.yml` (two permissions, both `restrict access: true`):

| Permission | Gates |
|---|---|
| `access migrate source ui` | The run form `/admin/content/migrate_source_ui` — uploading a source file and running a migration. |
| `administer migrate source ui` | The settings form `/admin/config/content/migrate_source_ui` — editing `file_temp_directory`. |

Both are marked security-sensitive (`restrict access: true`) because running a migration can
create/overwrite content in bulk and choosing an upload directory touches the filesystem —
grant only to trusted roles.

```bash
# let an "importer" role run file migrations from the UI
drush role:perm:add importer 'access migrate source ui'
# let site admins change the module settings
drush role:perm:add administrator 'administer migrate source ui'
```

The module adds no other access checks; the run form additionally relies on the underlying
Migrate/`migrate_tools` layer to actually execute the chosen migration.
