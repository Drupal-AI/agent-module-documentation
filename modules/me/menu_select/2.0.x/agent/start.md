<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Select — agent index

Replaces the core **"Parent item"** `<select>` on menu-link / node menu-settings forms with an
expandable menu **tree** plus an optional autocomplete **search**. Works by decorating the
core `menu.parent_form_selector` service; no new field type or plugin type. Depends on
`menu_ui`.

- **Turn search on/off, config key, config form route, permission** →
  [configure/settings.md](configure/settings.md)
- **How the replacement works: decorator, `menu_select_tree` element, tree-builder service,
  autocomplete route** → [api/architecture.md](api/architecture.md)

Key facts:
- Only config: `menu_select.settings:search_enabled` (boolean, default `true`), form at
  `/admin/config/content/menu_select` (route `menu_select.menu_select_config_form`). Note
  `info.yml` has **no `configure:` key**, so `data.json` `configure` is `null`.
- Only permission: `use menu select search` (`restrict access: true`).
- Submitted value is unchanged from core: `menu_name:menu_link_plugin_id`.
