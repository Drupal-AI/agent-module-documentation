<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MILE (Menu Item Link Enhancer) lets editors attach a node, block, or block_content entity to a menu link so that the rendered entity appears in place of the menu item's plain text/link.
---
The module alters the `menu_link_content` form (for users with the `administer mile references` permission) to add a "MILE references" fieldset with an entity-reference selector for a block, block_content (plus view mode), or node (plus view mode). The chosen reference is stored inside the menu link's link `options` via an entity builder. At render time, `mile_preprocess_menu()` and a decorator of the core `menu.link_tree` service (`MileMenuLinkTreeDecorator::build()`) walk the menu items, and for any item carrying `mile_references` they reload the referenced entity, build it with the configured view mode, and replace the item `title` with the rendered output. A `hook_theme()` entry plus `block_content_mile` template/suggestions work around the core issue that block_content entities have no default theme wrapper.

Security note: `_mile_render_menu_items()` reloads and renders the referenced entity directly into the menu markup without an explicit `->access('view')` check before rendering, and menus are typically shown to all users including anonymous. Because the reference is chosen at menu-edit time by a privileged user (gated by `administer mile references`), the exposure is limited to whatever entity that admin selected; however, if a referenced node is later unpublished or made access-restricted, or a low-visibility block_content is referenced, its rendered content could still surface in the menu to users who wouldn't otherwise be able to view it. Treat the `administer mile references` permission as trusted, and be deliberate about which entities you reference. The form-alter path uses the `permission_checker` service to gate editing, and the module has no routes of its own.
---
- Replace a menu link's text with a rendered node.
- Render a block in place of a menu item.
- Render a block_content entity (with a chosen view mode) in a menu.
- Build richer menus without a dedicated mega-menu module.
- Attach content to a main-menu item via the menu-link edit form.
- Pick a view mode for referenced nodes or block_content.
- Use `<nolink>` as the link value when replacing with an entity (recommended).
- Render MILE references when a menu is built with `\Drupal::menuTree()` (service decorator).
- Render MILE references in themed menus via `hook_preprocess_menu`.
- Theme referenced block_content with the provided `block-content-mile` templates.
- Use template suggestions per block_content type and view mode.
- Gate MILE editing with the `administer mile references` permission.
- Reload referenced entities at render time to reflect latest edits.
- Create image/promo-rich dropdown menu items.
- Embed a call-to-action block into a navigation menu.
- Reference existing content instead of duplicating it in menus.
- Restrict who can attach references to trusted editors.
- Review referenced entities' visibility to avoid surfacing restricted content.
- Combine with custom CSS to style the enhanced menu.