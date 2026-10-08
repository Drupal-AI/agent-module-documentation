<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# Configuration Partial Export — agent index

Export a *subset* of Drupal config — as a tarball from a UI tab, or into the config sync
directory via a Drush command. No settings, no configure route (`configure: null`), no config
schema, no plugins. Only a Drush command, a form tab, and a download controller.

- **The `config-partial-export` / `cpex` Drush command (wildcards, `--changelist`, sync dir)** →
  [drush/cpex.md](drush/cpex.md)
- **The "Partial Export" admin UI tab, its route, and the `export configuration` permission** →
  [configure/partial-export-ui.md](configure/partial-export-ui.md)

Key facts:
- Drush: `drush config-partial-export <names>` (alias `drush cpex`). Comma-separated, supports
  `*` wildcards. Writes active config objects as `.yml` into `Settings::get('config_sync_directory')`.
- `drush cpex --changelist` prints active-vs-sync differences instead of exporting.
- UI: `/admin/config/development/configuration/single/config-partial-export`, permission
  `export configuration` (core's own permission — this module defines none).
