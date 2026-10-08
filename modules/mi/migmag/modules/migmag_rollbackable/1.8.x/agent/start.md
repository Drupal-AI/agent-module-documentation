<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_rollbackable — agent index

Rollback-capable versions of core migrate **destination plugins**, ids prefixed
`migmag_rollbackable_`. No config, routes, permissions, or Drush. Has submodule
`migmag_rollbackable_replace` (auto-swaps core destinations).

- **The destination plugins + the two rollback DB tables** →
  [plugins/destinations.md](plugins/destinations.md)

Plugin ids (discover via `plugin.manager.migrate.destination`): `migmag_rollbackable_config`,
`migmag_rollbackable_theme_settings`, `migmag_rollbackable_default_langcode`,
`migmag_rollbackable_component_entity_display`,
`migmag_rollbackable_component_entity_form_display`, plus `migmag_rollbackable_color` and
`migmag_rollbackable_shortcut_set_users` (only when `color` / `shortcut` are installed).

DB tables (created on install): `migmag_rollbackable_data`, `migmag_rollbackable_new_targets`.
