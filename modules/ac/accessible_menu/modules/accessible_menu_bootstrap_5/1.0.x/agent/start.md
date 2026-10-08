<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Menu Bootstrap 5 (accessible_menu_bootstrap_5) — agent index

Submodule of **accessible_menu**. Adds a **Bootstrap 5** menu-library variant: a second
`accessible_menu_library` plugin, Bootstrap navbar templates, and an "Expand at" breakpoint.
Package `Other`. Depends on **`accessible_menu`**. Core `^10 || ^11`. GPL-2.0-or-later. Version
1.0.1. No routes, no permissions, no Drush of its own — it reuses the parent's settings form and
per-menu config.

- **Full details (plugin, form additions, block wiring, templates, config)** →
  [config/settings.md](config/settings.md)
- **Parent module** →
  [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)

## What it actually is

- **Plugin** `src/Plugin/AccessibleMenuLibrary/AccessibleMenuBootstrap5.php` — id
  `accessible_menu_bootstrap_5`, `base_path = "libraries/accessible-menu-bootstrap-5"`,
  `file_name = "accessible-menu-bs5.iife.js"`, CDNs jsdelivr/unpkg
  (`accessible-menu-bootstrap-5`). Four menu types with **Bootstrap5\*** constructors:
  `disclosure_menu`→`Bootstrap5DisclosureMenu`, `menubar`→`Bootstrap5Menubar`,
  `top_link_disclosure_menu`→`Bootstrap5TopLinkDisclosureMenu`, `treeview`→`Bootstrap5Treeview`.
- **`.module`** implements `hook_form_menu_form_alter` (adds an **Expand at** select `xs`–`xl`,
  default `lg`; extends `optional_key_support` visibility to the BS5 types; an AJAX callback
  `_accessible_menu_bootstrap_5_default_config_callback` swaps in Bootstrap default classes
  `collapse`/`collapsing` + duration `350` when a BS5 type is chosen), a submit handler saving
  `expand_at`, `hook_theme` (`menu__accessible_menu_bootstrap_5[…__top_link_disclosure_menu]`), and
  `hook_preprocess_block` (only when `menu === 'accessible_menu_bootstrap_5'`) that adds `navbar` /
  `navbar-expand-<expand_at>` classes and overrides `elementSelectors` to `.navbar-nav`,
  `.navbar-toggler`, `.navbar-collapse`.
- **`.install`** `hook_uninstall` deletes every `accessible_menu.menu.*` whose `menu` is
  `accessible_menu_bootstrap_5`.
- **Config**: install default `config/install/accessible_menu.library.accessible_menu_bootstrap_5.yml`;
  schema `config/schema/accessible_menu_bootstrap_5.schema.yml` redefines `accessible_menu.menu.*`
  adding the `expand_at` key.
- **Templates**: `templates/menu--accessible-menu-bootstrap-5.html.twig` and
  `…--top-link-disclosure-menu.html.twig` render Bootstrap navbar markup; links use core `link()` /
  `create_attribute()` (auto-escaped).
- Requires Bootstrap 5 CSS/JS from your theme — the submodule adds only classes + behaviour.
