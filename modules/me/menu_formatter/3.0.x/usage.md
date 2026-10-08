<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Formatter provides a "Rendered Menu" field formatter that turns an entity-reference field pointing at a menu into an actual rendered menu tree.

---

The problem it solves: you can reference a menu (a config entity) from a node or other entity, but by default Drupal only shows its label. This module's `MenuFieldFormatter` (for `entity_reference` fields) loads the referenced menu with `menu.link_tree`, applies the standard access manipulators — `checkNodeAccess`, `checkAccess`, then `generateIndexAndSort` — and renders the built tree, so the output respects menu-link and node access just like a normal menu block.

The formatter exposes two settings, **Menu Min Depth** (default 1) and **Menu Max Depth** (default 2), applied via `MenuTreeParameters`. Typical setup: create an entity-reference field that targets menu config entities, add a menu reference to your content, then on the entity's Manage Display set that field's format to "Rendered Menu" and tune the depths. No routes, permissions, services or writable state are added — it is a pure display plugin, so its security posture is inherited from core menu/node access checks.
---
- Render a referenced menu inline on a node's display
- Show a section/sidebar menu chosen per node via a reference field
- Let editors pick which menu appears on a page by selecting it in a field
- Limit the rendered menu to a depth range (min/max depth)
- Display a top-level-only menu by setting max depth to 1
- Build contextual navigation driven by content, not blocks
- Respect menu-link and node access in the rendered output
- Reuse core menu theming/markup for referenced menus
- Reference multiple menus in a multi-value field and render each
- Combine with menu_ui-managed menus
- Add per-landing-page navigation without custom blocks
- Show a menu inside a view mode (teaser, full)
- Avoid PHP/custom code for content-selected menus
- Configure min depth to skip the root level
- Use in paragraph or media entity displays that reference a menu
- Provide authors a simple UI to attach navigation to content
