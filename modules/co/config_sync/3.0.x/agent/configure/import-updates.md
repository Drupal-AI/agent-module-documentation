<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import distribution updates & update modes

config_sync has **no settings form of its own**. Its `configure` route is
`config_distro.import` → the **Distribution Updates** page at
`/admin/config/development/distro` (provided by config_distro). Any available config updates
from installed modules/themes/profiles are listed there for you to apply.

## Update modes

The mode decides how updates are applied. It is stored in **state** at key
`config_sync.update_mode` and read with the default `UPDATE_MODE_MERGE` when unset:

| Mode value | Constant | Meaning |
|---|---|---|
| `1` | `UPDATE_MODE_MERGE` (default) | Three-way merge (config_merge): apply the extension's changes but keep your local customizations. |
| `2` | `UPDATE_MODE_PARTIAL_RESET` | Reset only the config items that have available updates to the provided version (discards local edits on just those). |
| `3` | `UPDATE_MODE_FULL_RESET` | Reset **all** provided config to what the extensions currently ship. |

`DEFAULT_UPDATE_MODE = UPDATE_MODE_MERGE`. On the import form the mode selector is
Merge / Partial reset / Full reset. Set it in code / CLI:

```bash
drush state:set config_sync.update_mode 3    # full reset
drush state:get config_sync.update_mode
drush state:delete config_sync.update_mode   # back to default (merge)
```

## How updates are detected (snapshots)

- At install, `config_sync_install()` calls `config_sync.snapshotter->createSnapshot()`,
  recording the config each installed extension **provides** into the config_snapshot
  **snapshot set `config_sync`** (constant `CONFIG_SNAPSHOT_SET`). Snapshot entities are
  config_snapshot entities keyed `config_sync.<type>.<extension>`.
- `hook_modules_installed()` / `hook_themes_installed()` refresh the snapshot for newly
  installed extensions (`refreshExtensionSnapshot(..., SNAPSHOT_MODE_INSTALL)`).
- After you `composer update` a module, its provided config differs from the snapshot; the
  `config_sync.lister` builds a per-extension changelist (create/update ops) that the import
  page and `drush config-sync-list-updates` display.

## Applying

Apply from the Distribution Updates UI (select which extensions, choose the mode, submit) or
run the config_distro update from Drush (see [drush/commands.md](../drush/commands.md)). The
sync is performed through the `config_sync` config_distro filter plugin.
