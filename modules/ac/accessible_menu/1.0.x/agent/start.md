<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Menu (accessible_menu) — agent index

Attaches the third-party **accessible-menu** JS library (NickDJM/accessible-menu, ISC) to Drupal
**core menu blocks** so they become WAI-ARIA keyboard-navigable menus, configured **per menu**.
Package `Other`. Depends only on core **`menu_ui`**. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.1. Submodule: `accessible_menu_bootstrap_5`.

- **Site settings, the config objects, per-menu form fields, block wiring, templates** →
  [config/settings.md](config/settings.md)
- **The `accessible_menu_library` plugin type (add your own library)** →
  [plugins/library.md](plugins/library.md)

## What it actually is

- Not a block or entity of its own. It **hooks core menu rendering**. `.module` implements
  `hook_form_menu_form_alter` (adds an "Accessible Menu" fieldset to the *Structure → Menus* edit
  form), `hook_preprocess_block` (attaches libraries + `drupalSettings` to `system_menu_block` /
  `menu_block` blocks), `hook_preprocess_menu`, `hook_theme_suggestions_menu_alter`, `hook_theme`,
  `hook_library_info_build` (builds Drupal libraries from config at runtime), and
  `hook_entity_delete` (removes a menu's config when the menu is deleted).
- Defines a plugin type **`accessible_menu_library`** (annotation
  `src/Annotation/AccessibleMenuLibrary.php`, manager `AccessibleMenuLibraryPluginManager`,
  service `plugin.manager.accessible_menu_library`, interface + base in `src/`). Ships one plugin
  `AccessibleMenu` (`src/Plugin/AccessibleMenuLibrary/AccessibleMenu.php`) with four menu types:
  `disclosure_menu` (`DisclosureMenu`), `menubar` (`Menubar`), `top_link_disclosure_menu`
  (`TopLinkDisclosureMenu`), `treeview` (`Treeview`).
- One route: **`accessible_menu.settings`** at `/admin/config/development/accessible-menu`
  (`_permission: 'administer site configuration'`), form `src/Form/SettingsForm.php` — chooses CDN
  vs local install and the version per library. No permissions of its own, no Drush.
- Runtime JS: `js/accessible-menu-generator.js` (`Drupal.behaviors.accessibleMenu`, library
  `accessible_menu/generator`) instantiates `window[constructor]` on each configured menu block.
- **Provides no CSS** — it only adds ARIA attributes, keybindings, and class toggling.

## Config objects (schema in `config/schema/accessible_menu.schema.yml`)

- `accessible_menu.library.*` — one per library plugin. Installed default:
  `config/install/accessible_menu.library.accessible_menu.yml` (installation `cdn`, cdn `jsdelivr`,
  version `latest`, plus a `menu_types` map of label/constructor/path). Rebuilt on settings save.
- `accessible_menu.menu.<menu_id>` — the per-menu choice: `menu`, `type`, `collapsible`,
  `open_class`, `close_class`, `transition_class`, `transition_duration`, `open_duration`,
  `close_duration`, `optional_key_support`, `hover_type`, `hover_delay`, `enter_delay`,
  `leave_delay`. Written by `_accessible_menu_submit_handler`.

## Templates

`templates/menu--accessible-menu.html.twig` and `…--top-link-disclosure-menu.html.twig`; theme
suggestions injected by `hook_theme_suggestions_menu_alter` keyed on menu, type and menu name.
Menu links are rendered with core `link()` / `create_attribute()` (auto-escaped).

## Submodule

`accessible_menu_bootstrap_5` — see
[../../modules/accessible_menu_bootstrap_5/1.0.x/agent/start.md](../../modules/accessible_menu_bootstrap_5/1.0.x/agent/start.md).
