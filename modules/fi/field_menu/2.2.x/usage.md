<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Menu adds a `field_menu` ("Menu item") field type that stores a reference to a point in a Drupal menu and renders the menu tree rooted there, so you can drop a live, self-maintaining menu (for example a custom sitemap) onto any fieldable entity.

---

The module provides a single field type `field_menu` (class `MenuItemId`) with a matching widget `field_menu_tree_widget` and formatter `field_menu_tree_formatter`; it defines no settings form, configure route, permission, or Drush command. Each field value stores four columns: an optional `menu_title`, the chosen `menu_item_key` (a `menu_name:parent:link` string produced by core's `menu.parent_form_selector` "parent" select element), a `max_depth` (0 = unlimited), and an `include_root` flag. On the entity edit form the widget renders a Title textfield, a Root menu-item selector, a Max depth number field, and an "Include root?" checkbox; the widget respects two field-level settings, `menu_type_checkbox` (which menus are offered) and `menu_type_checkbox_negate` (treat that list as a hide-list). At display time the formatter loads the menu with `menu.link_tree`, sets the root and (optionally) max depth and excludes the root, applies the standard access/sort manipulators, and renders it through the `field_menu_item` template, which wraps the tree in an optional `<h2>` title. The module also registers extra `menu__…` theme suggestions (via `hook_theme_suggestions_menu()` and a `field_menu_configuration` variable added to the `menu` theme hook) so the rendered tree can be themed per entity type, bundle, view mode, and menu name.

---

- Render a custom, hand-curated sitemap page by adding a `field_menu` field to a Basic page and pointing it at the root of the main menu.
- Show a section's sub-navigation on a landing node by rooting the tree at that section's menu item.
- Display a "child pages" block-like list inside node content without writing a custom block.
- Build a documentation index that mirrors a docs menu and updates automatically as links are added.
- Put a footer-menu excerpt into a Paragraph so editors can place it anywhere in the layout.
- Limit an editor's menu choices to a single menu (e.g. only "main") via the `menu_type_checkbox` field setting.
- Hide administrative menus from the widget's Root selector using `menu_type_checkbox_negate`.
- Cap how deep a rendered tree goes with the per-value `max_depth` setting (e.g. only two levels).
- Include or exclude the selected root link itself with the "Include root?" toggle.
- Give a rendered menu tree an on-page heading via the optional Title field.
- Add several menu trees to one entity (cardinality > 1) to compose a multi-column sitemap.
- Attach a menu tree to a taxonomy term or media entity via that entity's field UI.
- Provide contextual "in this section" navigation driven entirely by the site's menu structure.
- Theme a specific field-menu tree differently using the `menu__<entity>__<bundle>__field_menu` suggestions.
- Reuse an existing menu as page content instead of duplicating links in a body field.
- Keep an HTML sitemap in sync automatically because it reads the live menu tree, not a static copy.
- Expose a partial menu (children only) by rooting at a parent and leaving "Include root?" off.
- Let content authors pick which menu branch to embed per node without developer involvement.
- Drive megamenu-style content regions from menu data stored on a node.
- Present an account/user menu subtree inside a dashboard node.
- Show a product-category menu branch on a category landing page.
- Build a "table of contents" style navigation from a book or custom menu.
- Store the menu selection as regular field data so it is portable across entity revisions.
- Output only enabled menu links (the formatter calls `onlyEnabledLinks()`), so disabled links never leak into content.
- Vary the embedded menu per view mode by using the view-mode-specific theme suggestion.
