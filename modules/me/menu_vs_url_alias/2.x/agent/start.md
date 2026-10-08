<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu vs. URL Alias (menu_vs_url_alias) — agent index

Per-content-type conditional validation that makes a node's **menu placement** and its **URL alias** an either/or choice. If the menu item is enabled, the alias/Pathauto fields are hidden; if not, a custom alias is **required**. A node with neither a menu title nor an alias (and no Pathauto) fails validation.

- **Type:** module. **Core:** `^9 || ^10 || ^11`. **License:** GPL-2.0-or-later. **Version dir:** 2.x (installed 2.1.0).
- **Dependency:** `pathauto` (Pathauto).
- **No** routes, controllers, Views, services, plugins, permissions, or Drush commands. All behavior is `hook_form_alter`-based.
- **Config:** `menu_vs_url_alias.settings:enabled_content_types` (array of content-type machine names; default `['page']`). No config schema shipped. Deleted on uninstall.

## What it hooks (`menu_vs_url_alias.module`)
- `menu_vs_url_alias_form_alter()` — on `*_menu_link_content_form`: hides `description` + `weight`. On `node_type_edit_form`: adds the "Menu vs. URL Alias Settings" details tab with the enable checkbox; adds submit handler `_menu_vs_url_alias_submit()`.
- `menu_vs_url_alias_form_node_form_alter()` — for enabled bundles: defaults menu on for new nodes, unchecks Pathauto, `#states`-hides the path widget when menu is enabled, makes alias required when menu is off, adds validate handler `_menu_vs_url_alias_validate()`.
- `_menu_vs_url_alias_submit()` — writes the ticked content type into `enabled_content_types`.
- `_menu_vs_url_alias_validate()` — errors if both menu title and alias are empty and Pathauto is off.

## Solution docs
- [agent/config/settings.md](config/settings.md) — the settings object, how the enable list is populated, install/enable/uninstall.
- [agent/api/form-behavior.md](api/form-behavior.md) — exact form-alter, `#states`, and validation logic.
