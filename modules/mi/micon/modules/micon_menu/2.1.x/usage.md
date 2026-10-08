<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon Menu lets editors attach a Micon icon to menu links (menu_link_content items and the menu link on the node edit form), and renders those icons automatically when the menu is themed.

---

The submodule overrides the core menu link widget: via `hook_entity_base_field_info_alter()` it swaps the `menu_link_content` `link` field's form widget to **`micon_menu`** (a `micon_link`-based widget), so the menu link add/edit form gains a Micon icon picker. It also alters the node form's "Menu settings" section (`hook_form_node_form_alter`, taking over `menu_ui`'s handling) and the menu-link-edit form to add an icon control, gated by the **`use micon menu`** permission. The chosen icon is stored on the menu link's `link` value as `options.attributes.data-icon` (position at `data-icon-position`). At render time `hook_preprocess_menu()` walks every menu item, and where a `data-icon` option is present it wraps the title with `MiconIconize` (honoring `after`/`icon_only`). The `user.logout` link is given a dynamic class so it can be iconized too. Global config `micon_menu.config` (key `packages`, edited at `/admin/structure/micon/link`, permission `administer micon`) limits which packages the menu icon pickers offer. Requires `menu_link_content`, `menu_ui`, and `micon_link`.

---

- Add a Font Awesome icon to each main-menu link.
- Give footer or utility menu links recognisable icons.
- Show icon-only menu items (e.g. a compact icon nav) via `data-icon-position: icon_only`.
- Place a menu icon before or after the link text.
- Set a menu-link icon directly on the node edit form's Menu settings.
- Add an icon to the login/logout menu link.
- Restrict which packages menu editors can choose icons from (global `micon_menu.config`).
- Gate icon editing to specific roles with the `use micon menu` permission.
- Store the icon on the menu link value so it exports/deploys with config or content.
- Render menu icons automatically in any theme without template changes (`hook_preprocess_menu`).
- Build an icon-driven sidebar navigation.
- Decorate breadcrumb-style menus with section icons.
- Add icons to menu links created from nodes via the node form.
- Keep consistent iconography across all site menus using one package.
- Provide a searchable icon picker in the menu link form.
- Add icons to admin or custom menus.
- Migrate a plain menu to an icon menu without editing each theme.
- Show social or contact icons in a menu block.
- Toggle a menu link between icon+text and icon-only per link.
- Combine with micon_link's formatter concepts for consistent link icons site-wide.
