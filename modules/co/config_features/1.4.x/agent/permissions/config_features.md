<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `config_features.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer configuration features` | The whole feature admin UI: the collection/list, add/edit/delete feature entities, enable/disable, and the activate/deactivate/import/export/diff operations. It is also the entity `admin_permission`. Marked **`restrict access: true`** (trusted — importing a feature writes to active configuration, which can change any site setting). |

The four batch **download** routes (`config_features.export_download*`) instead require the core
config permission **`export configuration`**, and `hook_file_download()` re-checks
`export configuration` before streaming the generated private tarball.

Grant via drush:
```
drush role:perm:add administrator 'administer configuration features'
```

There is no anonymous or low-privilege entry point: every state-changing route requires one of the
two permissions above.
