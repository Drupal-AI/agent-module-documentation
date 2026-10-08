<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Synchronizer — agent index

Imports config updates that modules/themes/profiles ship in new releases, into a live site,
without losing local edits. Built on config_distro + config_snapshot + config_merge +
config_normalizer + config_update. **No permissions, no config schema, no own settings form.**

- **The Distribution Updates page, the three update modes, snapshots, state key** →
  [configure/import-updates.md](configure/import-updates.md)
- **Drush: `config-sync-list-updates` / `cs-list`, `--update-mode` on `config-distro-update`** →
  [drush/commands.md](drush/commands.md)
- **Services (snapshotter, lister, collector), the SyncFilter plugin, interfaces & constants** →
  [api/services.md](api/services.md)

Key facts:
- `configure` route: **`config_distro.import`** (path `/admin/config/development/distro`) — the
  "Distribution Updates" page, provided by the config_distro dependency.
- Update modes stored in **state `config_sync.update_mode`**: `1` Merge (default), `2` Partial
  reset, `3` Full reset (`ConfigSyncListerInterface::UPDATE_MODE_*`; default = merge).
- Snapshots use the config_snapshot **snapshot set `config_sync`** (`CONFIG_SNAPSHOT_SET`);
  created at install and refreshed on module/theme install.
- Drush: `config-sync-list-updates` (alias `cs-list`); `drush config-distro-update --update-mode=N`.
