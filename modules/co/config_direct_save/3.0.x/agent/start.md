<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Direct Save — agent index

One-form utility that writes the **entire active configuration** to the config **sync
directory** (optionally backing it up first). No settings page, no config object, no
schema, no services, no plugins, no Drush. `configure` route is `null`.

- **The Update form: route, path, permission, backup behaviour, where it writes** →
  [configure/export.md](configure/export.md)

Key facts:
- Route `config_direct_save.update_configuration_form` → path
  `/admin/config/development/configuration/full/update`, shown as an **"Update"** local task
  on the core Synchronize page (`config.sync`).
- Permission: the **core** `export configuration` permission (the module ships no
  `permissions.yml` of its own).
- Writes to `Settings::get('config_sync_directory')` (on this site
  `sites/default/files/sync`); "Backup" first copies it to `sync-<d-m-Y-H-i-s>`.
