<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Menu Icons lets editors upload an image icon for individual menu links; the module generates a CSS file that renders each icon as a `background-image` on the corresponding menu item.

---

Simple Menu Icons is a small, config-free module that hangs off core's Menu UI. It alters the *menu link content* edit form (`menu_link_content_form`) to add an `icon_upload` **managed_file** field (accepting gif, png, jpg, jpeg and svg), stored into the menu link's own `link` options array under `menu_icon` (`fid` and `uri`). On submit it marks the uploaded file permanent, records file usage, then calls `simple_menu_icons_css_generate()`, which walks every `menu_link_content` row, renders the `simple_menu_icons_css_item` Twig template into a CSS file saved at `public://simple_menu_icons_css/menu_icons_<timestamp>.css`, and stores the timestamp suffix in State (`simple_menu_icons_css_suffix`). `hook_css_alter()` then injects that generated file into the page's CSS. Each menu item is tagged by `hook_preprocess_menu()` with `menu-icon` and `menu-icon-<mlid>` classes (recursively, so nested menus work), and the generated CSS uses those classes to set the icon as a left-aligned, no-repeat background image with left padding equal to the icon's pixel width. There is no admin settings page, no permission, no plugin, no Drush command and no config schema — the only persistent state is per-menu-link options plus the generated CSS file and its State suffix. The module regenerates the CSS on `hook_rebuild()` (e.g. a cache rebuild) so icons survive cache clears.

---

- Show a small brand or category icon next to a top-level menu link.
- Give each item in the main navigation its own uploaded icon.
- Add an SVG icon to a footer menu link without touching a theme.
- Let content editors set menu icons themselves from the familiar menu-link edit form.
- Use PNG/JPG/GIF icons where SVG is not available.
- Decorate an admin or account menu with recognisable glyphs.
- Provide visual cues in a mega-menu built from `menu_link_content` items.
- Keep icons working across cache clears (CSS is regenerated on rebuild).
- Apply icons to deeply nested submenu items (preprocessing recurses into child links).
- Attach an icon to a single menu link without affecting the others.
- Render icons as CSS `background-image` so no extra markup is required in menu templates.
- Automatically size link left-padding to the icon's width so text never overlaps the image.
- Target styling precisely via the generated `menu-icon-<mlid>` per-link CSS class.
- Add `menu-icon` / `menu-icon-<mlid>` classes to menu items for custom theming even without an image.
- Swap an existing menu link's icon by uploading a replacement file.
- Remove an icon by clearing the managed-file widget on the link.
- Serve icons from the public files directory with Drupal's aggregated CSS pipeline.
- Brand a language or social menu with per-link flags/logos.
- Provide iconography for a documentation or product menu.
- Give a store's category menu distinct icons per department.
- Ensure uploaded icon files are kept permanent (not garbage-collected by cron).
- Reference the generated icon CSS automatically on every page via `hook_css_alter()`.
