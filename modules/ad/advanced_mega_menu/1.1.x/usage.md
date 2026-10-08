<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Mega Menu turns ordinary Drupal menus into rich, multi-column mega-menu panels by letting an administrator fill each top-level menu item with a grid of rows and columns holding Views displays, block content, and theme/system blocks, built through a visual "canvas" layout builder.

---

The module works on menus you explicitly opt in (globally at *Structure → Advanced Mega Menu → Configuration*, or per-menu via the "Enable Mega Menu" operation on *Structure → Menus*). For an enabled menu, hovering a menu link in the menu-edit UI reveals two builder entry points — a gear icon that opens the layout builder (`MegaMenuLayoutBuilderForm`) in an AJAX modal, and an external-link icon that opens it full-screen in a new tab. In the builder you add **rows**, choose a **column width mode** per row (auto, equal, fractional, flexible-wrap, min/max, proportional, dynamic-stack, adaptive, or a fixed 2–6 columns, or a *custom* mode where you supply your own CSS classes), add **columns**, and drop **blocks** into columns from three sources: a *Content Block* (Block Content entity), a *View Block* (a Views `block` display, chosen as `view_id:display_id`), or a *Theme/System Block* (a placed block in the default theme). Each block can optionally show its label. Layouts are capped for safety at 30 rows, 24 columns per row, and 16 blocks per column. Every configured menu item is stored as a `megamenu_content` config entity keyed by the menu-link UUID and the menu machine name; the entity's *display settings* decide whether the item renders the mega rows only, the normal child menu links only, or both (with the links placed above or below the grid), and hold fallback wrapper/row/column CSS classes. At render time `hook_preprocess_menu` detects an enabled menu, swaps in the `menu--advanced-mega-menu.html.twig` template, and calls the `MegaMenuRowBuilder` service, which loads the entity and produces a render array themed by `advanced-mega-menu.html.twig`; the `MegaMenuBlockRenderer` service materialises each embedded View/block. A global submenu-icon option adds a themeable expand/collapse indicator (Unicode symbol or icon-font class with ARIA labels), and a "disable assets" switch lets you supply your own CSS/JS. For decoupled sites, a REST resource exposes `GET /api/advanced-mega-menu/{menu_id}/{plugin_id}` returning the rendered mega-menu HTML. All building, editing and deleting is gated by the restricted `administer advanced mega menu` permission. The module provides only the structural grid engine and minimal CSS — final visual design is left to the active theme.

---

- Build a multi-column mega-menu panel under a top-level "Products" link, with categories in separate columns.
- Embed a "Latest news" or "Featured articles" Views block directly inside a menu dropdown so it updates automatically.
- Place a promotional custom Block Content banner (image + CTA) into a menu column without editing templates.
- Drop a theme/system block such as Search or Site Branding into a mega-menu column.
- Mix a Views "Deal of the Day" display with static category links in the same dropdown.
- Show a "Trending in this section" list via a Views contextual filter inside the relevant top-level item.
- Enable mega-menu behaviour only on the Main menu while leaving Footer and other menus untouched.
- Enable it on several menus at once (Main, Footer, User) from the global configuration form.
- Choose "Mega menu rows only" to hide the normal child links and show only your grid content.
- Choose "Menu items + mega menu rows" and position the child links above or below the grid.
- Choose "Menu items only" to render the built-in two-level children in the mega layout without extra blocks.
- Lay out a row as fixed 2/3/4/5/6 equal columns for a predictable grid.
- Use auto / flexible-wrap / min-max column modes for content-driven responsive columns.
- Switch a row to "custom" mode and apply your own Bootstrap/Tailwind grid classes to the row and each column.
- Add fallback wrapper, row, and column CSS classes globally for consistent theming across items.
- Show a per-block label above each embedded View or block.
- Reorder blocks within a column by drag-and-drop (weights are saved on submit).
- Add an expand/collapse submenu icon (Unicode chevron or FontAwesome/Flaticon class) with screen-reader ARIA labels.
- Feed a headless React/Vue front-end the rendered mega-menu markup for a menu item via the REST endpoint.
- Cache-aware REST output that invalidates when the mega-menu content or the menu configuration changes.
- Disable the module's bundled CSS/JS and style the mega menu entirely from your theme.
- Rely on built-in row/column/block count limits to keep menu configuration from growing unbounded.
- Delete a menu item's mega-menu configuration through the Mega Menu Items admin list without deleting the menu link.
