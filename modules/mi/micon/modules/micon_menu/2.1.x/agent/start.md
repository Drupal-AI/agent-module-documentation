<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon Menu — agent index

Adds a Micon icon to menu links and renders it automatically when menus are themed. Requires
`menu_link_content`, `menu_ui`, `micon_link`.

- **Permission, global config, config form, icon storage & the `micon_menu` widget** →
  [configure/menu-icons.md](configure/menu-icons.md)

Key facts (grounded in `micon_menu.module`):
- **Widget:** `hook_entity_base_field_info_alter()` sets the `menu_link_content` `link` field's
  form widget to **`micon_menu`**; the node form's Menu settings and the menu-link-edit form
  also gain an icon control (permission-gated).
- **Storage:** the icon lives on the menu link's `link` value at
  `options.attributes.data-icon` (position at `data-icon-position`).
- **Render:** `hook_preprocess_menu()` iconizes any item whose Url has a `data-icon` option
  (via `MiconIconize`, honoring `after`/`icon_only`).
- **Permission:** `use micon menu` gates who can set icons. Global config `micon_menu.config`
  (`packages`) limits offered packages; form at `/admin/structure/micon/link`.

See the parent `micon` docs for the icon selector / `micon()` API and `micon_link` for the
shared widget trait.
