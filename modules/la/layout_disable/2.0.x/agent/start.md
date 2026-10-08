<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Disable — agent index

Admin UI to **disable layout plugins** (core/theme/contrib) so they disappear from every layout
picker (Layout Builder, Display Suite, etc.). Depends on `layout_discovery`. No plugins of its
own, no Drush.

- **Disable/enable layouts: config key, route, permission, mechanism** →
  [configure/disable.md](configure/disable.md)

Key facts:
- Config object `layout_disable.settings`, key **`disabled_layouts`** = associative list keyed by
  layout plugin id (`{layout_id: layout_id}`).
- `hook_layout_alter()` removes those ids from layout definitions (`array_diff_key`).
- Form route **`layout_disable`** → `/admin/config/user-interface/layout-disable`, permission
  **`access layout_disable`**.
- `layout_onecol` and `layout_builder_blank` are core-required and cannot be disabled.
- After changing the config you must clear the layout plugin manager's cached definitions
  (`plugin.manager.core.layout`) for the change to show; the form does this automatically.
