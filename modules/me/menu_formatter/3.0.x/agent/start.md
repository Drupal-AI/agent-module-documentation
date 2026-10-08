<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Formatter (menu_formatter) — agent index

**Field formatter that renders a referenced menu config entity as an access-checked menu tree.**

- **Version:** 3.0.x
- **Core:** ^8.8 || ^9 || ^10
- **Dependencies:** menu_ui
- **Plugin:** `@FieldFormatter(id="menu_field_formatter", label="Rendered Menu")` for `entity_reference` fields.
- **Settings:** `menu_min_depth` (default 1), `menu_max_depth` (default 2).
- **Services used:** `menu.link_tree`, `renderer`, `current_user`.

**Security:** Pure display plugin — no routes, permissions, services, or writable state. Renders via `menu.link_tree` with `checkNodeAccess` + `checkAccess` manipulators, so menu-link and node access are enforced. No security findings.

See [configure/formatter.md](configure/formatter.md)
