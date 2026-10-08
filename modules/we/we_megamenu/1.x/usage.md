We Mega Menu turns any existing Drupal menu into a rich, multi-column mega menu with a drag-and-drop backend builder, letting you drop Drupal blocks (video, forms, views, custom HTML) into the dropdown panels and control per-menu animation and behavior.

---

The module works on top of core menus rather than replacing them: you keep building menu links in Structure > Menus, and We Mega Menu layers a visual builder on top at Structure > Mega Menu (`/admin/structure/we-mega-menu`). For each menu it derives a "Mega Menu" block (`we_megamenu_block:<menu_name>`, one per menu) that you place in a region to render the front-end menu. Each menu's layout is stored not as a config entity but as a JSON blob in a custom database table `we_megamenu`, keyed by `(menu_name, theme)`, with the payload in a `data_config` column; the `WeMegaMenuBuilder` helper class (`loadConfig`/`saveConfig`/`initMegamenu`) is the programmatic entry point. The stored JSON holds a `menu_config` map (per menu item: rows, columns, widths, assigned block, icon, caption, alignment) plus a `block_config` object of render behaviors (`style`, `animation`, `delay`, `duration`, `action` hover vs clicked, `auto-mobile-collapse`, and more). The builder UI saves through AJAX routes and the front end is rendered by a stack of theme hooks (`we_megamenu_frontend` down through `we_megamenu_ul` / `we_megamenu_li` / `we_megamenu_submenu` / `we_megamenu_row` / `we_megamenu_col` / `we_megamenu_block`) whose Twig templates ship in `templates/`. Entity hooks keep the stored layout in sync when menu links are added, edited, or deleted. A single permission, `administer we_megamenu`, gates the builder, and `hook_megamenu_manipulators_alter()` lets other modules alter the menu-tree manipulators (e.g. for per-language filtering). Styling and JavaScript arrive through two libraries, `we_megamenu/form.we-mega-menu-backend` (builder) and `we_megamenu/form.we-mega-menu-frontend` (rendered menu), which pull in Bootstrap, jQuery UI, and Chosen.

---

- Turn a site's Main navigation into a multi-column mega menu with grouped links.
- Add a full-width dropdown panel under a top-level menu item.
- Drop a Drupal block (e.g. a promo, contact form, or view) inside a menu dropdown column.
- Embed a video block in a mega menu panel for a marketing landing menu.
- Build a footer or utility menu with a custom multi-column layout.
- Give each menu item a Font Awesome icon and caption in the dropdown.
- Split a dropdown into several columns with configurable Bootstrap-style widths (`span1`..`span12`).
- Configure whether a submenu opens on hover or on click per menu (`block_config.action`).
- Add an open/close animation (e.g. `fadeInUp`) with delay and duration to a menu's dropdowns.
- Enable auto mobile collapse so the mega menu becomes a hamburger menu on small screens.
- Place the derived Mega Menu block (`we_megamenu_block:<menu>`) in the header region.
- Maintain menu links the normal way in Structure > Menus and have the layout stay in sync.
- Reset a menu's mega-menu layout back to the default derived from its links.
- Build a language-aware mega menu by adding a tree manipulator via `hook_megamenu_manipulators_alter()`.
- Programmatically seed a menu's mega-menu config with `WeMegaMenuBuilder::initMegamenu()` during deployment.
- Read a menu's stored layout in code with `WeMegaMenuBuilder::loadConfig($menu_name, $theme)`.
- Override the front-end markup by supplying your theme's own `we-megamenu-*.html.twig` templates.
- Change the backend builder skin/style used while editing (stored in state `we_megamenu_backend_style`).
- Hide specific columns when the menu collapses on mobile (`hidewhencollapse`).
- Show or hide a block's title when embedding it in a column (`block_title`).
- Give a menu item a custom CSS class or link target for theming and behavior.
- Present a large e-commerce category menu with images and links across several columns.
- Build a "products / solutions / resources" style SaaS navigation with rich dropdowns.
- Keep one layout per active theme by storing config per `(menu_name, theme)` pair.
- Group child links under a heading inside a dropdown using the group flag.
- Add an always-visible submenu (`always-show-submenu`) for a directory-style menu.
