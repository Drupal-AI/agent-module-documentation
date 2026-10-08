<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Parent Form UI (menu_parent_form_ui) — agent index

Client-side (JS) enhancement that replaces core's single combined **parent-menu dropdown** with
**cascading select boxes** (menu → parent → sub-parent) on **node** forms and **menu_link_content**
forms. Easier on large/deep menus. Depends only on core **`menu_ui`**. Package `Widgets`. Version
**1.1.0** (dir `1.1.x`). Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later.

- **Settings form, config object + schema, install update** →
  [config/settings.md](config/settings.md)
- **How the form-alter + JS cascade works (node form & menu link form)** →
  [behavior/cascading-selects.md](behavior/cascading-selects.md)

## What it actually is (from source)

- **No entities, no plugins, no permissions, no Drush, no routes** except one settings form.
- **Hooks** (OOP, `src/Hook/MenuParentFormUiHooks.php`, registered via `#[Hook(...)]` and mirrored
  as `#[LegacyHook]` wrappers in `menu_parent_form_ui.module`):
  - `form_node_form_alter` → adds an `#after_build` (`nodeFormAfterBuild`) that, when the Menu
    settings section is accessible and not disabled, calls `parseMenuTrail()` on
    `$form['menu']['link']['menu_parent']['#default_value']`.
  - `form_menu_link_content_form_alter` → calls `parseMenuTrail()` on
    `$form['menu_parent']['#default_value']`.
  - `parseMenuTrail()` computes the active trail via `plugin.manager.menu.link`
    (`getParentIds()`), then attaches library `menu_parent_form_ui/menu_parent_form_ui.base` and
    three `drupalSettings` values: `active_set` (the trail) and the two configured wrapper
    selectors.
- **Service** (`menu_parent_form_ui.services.yml`): the hook class is autowired; it injects
  `plugin.manager.menu.link` (`MenuLinkManagerInterface`) and `config.factory`. Param
  `menu_parent_form_ui.skip_procedural_hook_scan: true`.
- **Library** `menu_parent_form_ui.base` (`*.libraries.yml`): `js/menu_parent_form_ui.js`
  (behavior) + `js/libs/select_extractor.js` (the `SelectExtractor` class) + `css/*.css`; depends
  on `core/drupalSettings` and `core/once`.
- **Settings route** `menu_parent_form_ui.settings` at
  `/admin/config/user-interface/menu-parent-form-ui`, `_permission: 'administer site configuration'`;
  menu link under *Configuration → User interface* (`*.links.menu.yml`).
- **Config** object `menu_parent_form_ui.settings` with two keys (both CSS selector strings), schema
  in `config/schema/`, defaults in `config/install/`. See config/settings.md.

## New in 1.1.0 vs 1.0.x

- Adds core `^12` to `core_version_requirement`.
- The two **wrapper-selector settings** are configurable and are attached to the form via
  `drupalSettings` (JS now reads `drupalSettings.<...>_wrapper_selector` instead of a hardcoded
  container), letting the widget work on non-Claro themes. `menu_parent_form_ui_update_10101()`
  backfills the two config values on existing sites (issue #3552420).
