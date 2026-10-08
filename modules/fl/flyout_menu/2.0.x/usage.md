<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flyout Menu adds a configurable slide-in (off-canvas) menu to a Drupal site, provided as blocks with a toggle control and a settings form.

---

The module ships two blocks — a flyout menu block and a toggle block — plus front-end libraries (CSS/JS built via gulp/scss) that animate the panel in and out. A settings form at /admin/config/user-interface/flyout-menu (route flyout_menu.settings, perm 'administer site configuration') controls the menu's behaviour and appearance. You place the toggle block where you want the open control (e.g. a header) and the menu block for the panel content, then style via the provided library. It is a presentational navigation enhancement with no entities or permissions of its own. Templates are overridable for theming. Use it for mobile navigation, secondary menus, or any slide-in panel pattern.

---

- Add a mobile hamburger menu that slides in from the side.
- Provide an off-canvas navigation panel in the site header.
- Show a secondary menu in a flyout to save header space.
- Toggle a slide-in cart or account menu.
- Give a responsive site a touch-friendly navigation drawer.
- Place the open/close toggle anywhere via a dedicated block.
- Render the main menu inside an animated panel.
- Style the flyout with the module's SCSS-built library.
- Override the flyout template for custom markup.
- Configure flyout behaviour from a single settings form.
- Use a flyout for filters or facets on listing pages.
- Add a slide-in menu without writing custom JavaScript.
- Improve navigation UX on small viewports.
- Keep primary content unobstructed until the menu is opened.
- Provide a consistent flyout across multiple regions.
- Combine the toggle and menu blocks in different theme regions.
