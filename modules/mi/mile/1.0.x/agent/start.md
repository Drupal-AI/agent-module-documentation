<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MILE (mile) — agent index

**Replaces a menu item's title/link with a rendered node, block, or block_content entity (chosen per menu link, rendered via a menu.link_tree decorator).**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Dependencies:** drupal:menu_link_content
- **Service:** `mile.menu_link_tree_decorator` decorates core `menu.link_tree` → `build()` renders references
- **Hooks:** form alter on `menu_link_content_form` (gated by `permission_checker` + `administer mile references`), `preprocess_menu`, `hook_theme` (`block_content_mile`), theme suggestions
- **Permission:** `administer mile references`
- **Security:** `_mile_render_menu_items()` (mile.module) reloads and renders the referenced entity into menu markup **without an explicit `->access('view')` check** before rendering; menus are shown to all users. Exposure is bounded by the `administer mile references` permission (only a trusted admin picks the reference), but a later-unpublished/restricted node or a low-visibility block_content could surface in the menu. Treat the permission as trusted and vet referenced entities. No routes of its own.

See [extend/references.md](extend/references.md)