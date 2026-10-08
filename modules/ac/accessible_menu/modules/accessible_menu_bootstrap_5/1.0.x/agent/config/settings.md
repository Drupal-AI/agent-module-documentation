<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Menu Bootstrap 5 — configuration

## Install & enable

```bash
drush en accessible_menu_bootstrap_5 -y
```

Requires the parent **`accessible_menu`** module (auto-enabled). It has **no route, permission, or
settings form of its own** — the library's CDN/local/version choice is made on the parent's
`accessible_menu.settings` form (`/admin/config/development/accessible-menu`), which now lists the
Bootstrap 5 library as a second fieldset because the plugin is discovered automatically.

## The library plugin

`src/Plugin/AccessibleMenuLibrary/AccessibleMenuBootstrap5.php` (extends the parent's
`AccessibleMenuLibraryPluginBase`), annotation id **`accessible_menu_bootstrap_5`**:

- `base_path = "libraries/accessible-menu-bootstrap-5"`, `dist_dir = "dist"`,
  `file_name = "accessible-menu-bs5.iife.js"`.
- CDNs `jsdeliver` (`//cdn.jsdelivr.net/npm/accessible-menu-bootstrap-5`) and `unpkg`.
- Menu types (constructor = JS global instantiated by the parent's generator script):

| Type | Constructor | file_name |
|---|---|---|
| `disclosure_menu` | `Bootstrap5DisclosureMenu` | `disclosure-menu-bs5.iife.js` |
| `menubar` | `Bootstrap5Menubar` | `menubar-bs5.iife.js` |
| `top_link_disclosure_menu` | `Bootstrap5TopLinkDisclosureMenu` | `top-link-disclosure-menu-bs5.iife.js` |
| `treeview` | `Bootstrap5Treeview` | `treeview-bs5.iife.js` |

Install default: `config/install/accessible_menu.library.accessible_menu_bootstrap_5.yml`
(installation `cdn`, cdn `jsdelivr`, version `latest`, with the `menu_types` map).

## Per-menu form additions (`hook_form_menu_form_alter`)

Runs on the *Structure → Menus → edit* form after the parent has built the "Accessible Menu"
fieldset:

- Adds **Expand at** select (`xs`/`sm`/`md`/`lg`/`xl`, default `lg`), visible only for the four
  `accessible_menu_bootstrap_5--*` types when **Collapsible** is checked; weighted right under
  Collapsible. Saved to `accessible_menu.menu.<id>` key **`expand_at`** by
  `_accessible_menu_bootstrap_5_submit_handler`.
- Extends the parent's `optional_key_support` visibility to the BS5 disclosure / top-link
  disclosure types.
- On a fresh menu (type `none`) attaches an AJAX callback
  `_accessible_menu_bootstrap_5_default_config_callback` to the type select: when a BS5 type is
  chosen it swaps the class defaults to Bootstrap values (`close_class` `collapse`,
  `transition_class` `collapsing`, `transition_duration` `350`); otherwise it restores the base
  defaults (`hide` / `transitioning` / `250`).

Config schema `config/schema/accessible_menu_bootstrap_5.schema.yml` redeclares
`accessible_menu.menu.*` including the extra `expand_at` string.

## Block wiring (`hook_preprocess_block`)

Only acts on `system_menu_block` / `menu_block` blocks whose `accessible_menu.menu.<id>` has
`menu === 'accessible_menu_bootstrap_5'`:

1. adds class `navbar`, and `navbar-expand-<expand_at>` when the menu is collapsible;
2. overrides `drupalSettings.accessibleMenu.menus[<block id>].elementSelectors` to Bootstrap's
   `.navbar-nav` (menu element), `.navbar-toggler` (controller), `.navbar-collapse` (container),
   so the parent's generator script drives the standard Bootstrap navbar structure.

The rest of the `drupalSettings` payload (constructor, options, durations, hover) is still built by
the parent's `accessible_menu_preprocess_block()`.

## Templates

`hook_theme` registers `menu__accessible_menu_bootstrap_5` and
`menu__accessible_menu_bootstrap_5__top_link_disclosure_menu`; the parent's
`hook_theme_suggestions_menu_alter` supplies matching suggestions. The templates in `templates/`
emit Bootstrap navbar markup (`navbar-toggler`, `collapse navbar-collapse`, `navbar-nav`,
`dropdown` / `dropdown-menu` / `nav-link` / `dropdown-item` etc.), rendering each link with core
`link()` + `create_attribute()` (auto-escaped). **Bootstrap 5's own CSS/JS is not bundled** —
supply it from your theme.

## Uninstall

`hook_uninstall` (`accessible_menu_bootstrap_5.install`) loads all `accessible_menu.menu.*` config
and deletes any whose `menu` is `accessible_menu_bootstrap_5`, so removing the submodule cleans up
menus that were using it.
