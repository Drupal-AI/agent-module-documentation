TB Mega Menu ("The Better Mega Menu") turns any Drupal core menu into a multi-column mega menu with a drag-and-drop back-end builder, letting you mix menu links with Drupal blocks, custom classes, icons, animations and built-in styles. It renders each menu-plus-theme pairing as a derivative block you place in a region.

---

TB Mega Menu builds on Drupal core menus rather than replacing them: you pick an existing menu (e.g. Main navigation) and a theme, and the module stores its layout in a `tb_megamenu` config entity keyed as `{menu}__{theme}`. Its visual back-end (Structure → TB Mega Menu) lets you arrange menu items into rows and Bootstrap-style 12-column grids, drop any accessible Drupal block into a column, and set per-item options (extra CSS class, Font Awesome icon/xicon, caption, alignment, grouping, hide-when-collapsed). Block-level settings control the animation effect (none, fading, slide, zoom, elastic), transition duration/delay, a built-in color style (default, black, blue, green), auto-arrow, always-show-submenu, off-canvas and forced column count. Each configured menu/theme combo is exposed as a derivative of the `tb_megamenu_menu_block` block plugin, which you place like any other block; the block declares cache tags for its menu and config entity and varies by the menu's active trail. Rendering flows through a `#theme => 'tb_megamenu'` element and a stack of overridable Twig templates and preprocess functions. Menu changes made in core stay synchronized because the module reads the core menu tree and merges its stored config. Config is stored as JSON strings inside the config entity and sanitized (HTML-escaped) on read to guard against XSS. It requires no other contrib modules; the Chosen library is an optional admin nicety.

---

- Build a horizontal main-navigation mega menu with multi-column dropdown panels.
- Add Drupal blocks (views, custom HTML, media, forms) directly inside a menu dropdown.
- Create feature-rich flyouts that combine menu links, images, and promotional blocks.
- Lay out dropdown contents on a 12-column Bootstrap-style grid with per-column widths.
- Apply a built-in color style (black, blue, green) to a menu without writing CSS.
- Add CSS3 open/close animations (fading, slide, zoom, elastic) with custom duration and delay.
- Attach Font Awesome icons (xicon) to menu items for visual navigation cues.
- Give individual menu items custom CSS classes for theme-specific styling.
- Add non-linking caption/heading items that group links within a dropdown column.
- Hide selected submenu items when the menu collapses to its mobile/off-canvas state.
- Configure an off-canvas mobile menu presentation for small screens.
- Keep the menu automatically in sync with edits made in Drupal core's menu UI.
- Maintain separate mega menu layouts per theme for the same underlying menu.
- Place the same menu as different derivative blocks in header, footer, or sidebar regions.
- Force a fixed number of columns for a submenu regardless of content.
- Toggle auto-arrow indicators on parent items that have children.
- Keep submenus always visible ("always-show-submenu") for tap-friendly navigation.
- Show or hide block titles within mega menu columns.
- Provide keyboard- and screen-reader-accessible dropdown navigation out of the box.
- Override the menu's markup by copying its Twig templates into your theme.
- Export a finished mega menu layout as configuration for deployment across environments.
- Reuse an existing menu as a rich mega menu without duplicating link data.
- Programmatically read or rebuild a menu's stored layout via the `tb_megamenu.menu_builder` service.
- Restrict who can build mega menus with the `administer tb_megamenu` permission.
- Add group/panel wrappers around submenu columns for complex layouts.
- Align submenu panels left/right relative to their parent item.
