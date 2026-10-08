<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drulma Companion is a helper module for the Bulma-based Drulma theme, providing Bulma-styled blocks, Font Awesome 5 template suggestions, an entity-reference field formatter, and a Drush subtheme generator.

---

Drulma Companion (package "Bulma") supplies the pieces of the Drulma theme's front end that must live in a module rather than a theme. It ships three block plugins that map Drupal navigation and local tasks onto Bulma components (a navbar with branding, Drupal's primary/secondary tabs as Bulma tabs, and any Drupal menu as Bulma tabs), a field formatter that renders entity-reference labels as Bulma tags, two attribute-driven hook classes (one that adds Font Awesome 5 template suggestions, one that adds a Bulma `container` class to Drulma's core blocks when the theme is installed), and a Drush code generator (`drush generate drulma`) that scaffolds a Drulma subtheme. It depends on the Block Class module because Bulma styles elements by CSS class, and it works together with the Drulma theme (pulled in via Composer). The optional `drulma_menu_item_fields` submodule integrates with Menu Item Fields so navbar menu links carry the right Bulma classes. The module provides no settings form, no permissions, and no content or access behavior of its own.

---

- Add a Bulma navbar with the site logo, name, and slogan plus optional left and right menus.
- Place a hero-footer tab bar using Drupal's primary/secondary local tasks styled as Bulma tabs.
- Render any Drupal menu as a horizontal Bulma tab bar.
- Center a navbar or tab bar horizontally with a Bulma `.container`.
- Colorize a navbar using Bulma navbar colors (primary, link, info, success, warning, danger, black, dark, light, white).
- Choose the HTML tag (`span`, `div`, or `h1`–`h5`) wrapping the navbar site title.
- Toggle which branding elements (logo, name, slogan) appear in the navbar and size the name/slogan with Bulma typography helpers.
- Show a second menu at the end (right side) of the navbar, with its own start level and depth.
- Style menu tabs as boxed, toggle (mutually exclusive), toggle-rounded, fullwidth, or sized (small/medium/large).
- Align tabs left, centered, or right.
- Limit a menu-as-tabs block to a single level (default depth 1) so multilevel tabs don't render awkwardly.
- Display an entity-reference field (e.g. taxonomy terms) as Bulma tags on entity displays.
- Choose tag size, color, rounded corners, and inline (`.tags` container) layout for the label formatter.
- Add Font Awesome 5 template suggestions to inputs, selects, submit buttons, feed icons, and file links.
- Target a specific submit button, input type, form ID, field name, or file MIME type with a `__fa5` template override.
- Automatically add a Bulma `container` class (via Block Class) to Drulma's branding, footer, powered, and messages blocks when Drulma or a Drulma-based theme is installed.
- Scaffold a new Drulma subtheme with `drush generate drulma`, copying Drulma's settings, schema, optional block config, favicon, logo, and template directory structure.
- Override navbar and tab menu-link markup through the module's dedicated theme suggestions (`menu__bulma_navbar__…`, `menu__bulma_tabs__…`).
- Integrate Menu Item Fields with Drulma navbars (via the `drulma_menu_item_fields` submodule) so menu-link content gets Bulma navbar classes.
