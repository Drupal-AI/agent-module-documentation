<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provus Mega Menu is a presentation module for the Provus base theme that renders the main menu as a full-width, multi-column "mega menu" with optional callout image/link panels and per-item icons.

---

The module is a thin theming layer, not a configurable feature. It ships one Twig template (`menu--extras.html.twig`) registered as the theme hook `menu__extras` (base hook `menu_item_extras`, so it overrides the Menu Item Extras rendering) and an asset library `provus_mega_menu/main-nav` (Bootstrap-style CSS + `main-navigation.js` / `main-nav-behavior.js`, depending on `core/drupal`, `core/jquery`, `core/drupal.debounce` and the `provus_base_theme/global-styling` library). Its only PHP is a `hook_form_alter()` on the `menu_link_content_main_form` that uses `#states` to show the fields `field_provus_menu_callout_image` and `field_provus_menu_callout_link` only on top-level (parent = `main:`) items, and `field_provus_menu_icon` only on child items — and a `hook_theme()` registering the template. Those callout/icon fields are **not created by this module**; they come from the Provus distribution/recipe and are attached to menu link content, and the template reads them (`item.content.field_provus_menu_callout_image`, `…callout_link`, `…icon`) to render the right-hand callout panel at menu level 1 and icons on child links. There is no settings form (`configure: null`), no permissions, no Drush, no config schema, and no plugins. It requires `menu_item_extras` and is designed to run inside the Provus base theme; outside that theme the CSS/JS dependency (`provus_base_theme/global-styling`) and expected fields will be missing.

---

- Render the site's main menu as a full-width Bootstrap-style mega menu on a Provus site.
- Show a callout image panel on the right side of a top-level menu dropdown.
- Add a callout link (e.g. a promoted CTA) alongside the mega menu columns.
- Display an icon next to second-level (child) menu links via `field_provus_menu_icon`.
- Reorder mega-menu columns based on a parent item's children.
- Provide flexible column widths within the mega menu layout.
- Override Menu Item Extras' menu rendering with the Provus `menu--extras` template.
- Attach the `provus_mega_menu/main-nav` library (CSS/JS) to the main navigation.
- Constrain callout image/link fields to only appear on first-level menu items in the edit form.
- Constrain the icon field to only appear on child menu items in the edit form.
- Give a government (Provus Gov) site a structured, accessible mega menu.
- Add keyboard/hover behavior to the main navigation via the bundled JS behaviors.
- Present a multi-column dropdown for menus with many children.
- Keep the callout panel hidden on small screens (`d-none d-lg-block`) and shown on large.
- Theme the main menu without writing a custom menu template from scratch.
- Combine Menu Item Extras field-on-menu-item data with a mega-menu presentation.
- Provide `nav-link` / `dropdown` Bootstrap classes and active-trail states for menu items.
- Use `clean_class`-based per-link classes for targeted styling.
- Roll the mega menu into a Provus subtheme/recipe install.
- Show promotional imagery inside a specific top-level menu section.
- Ensure child links with icons get a `has_icon` class for styling.
