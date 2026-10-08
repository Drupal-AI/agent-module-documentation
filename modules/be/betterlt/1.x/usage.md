<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Local Tasks replaces core's rendering of the local task tabs — the View / Edit / Delete / Revisions / Translate tab strip — with a fixed, icon-based panel that hides against the left edge of the screen and slides in on hover.

---

Local tasks are the small tab strip Drupal shows on many entity pages. This module (machine name `better_local_tasks`, project `betterlt`, 1.x branch = release 8.x-1.4) is a pure presentation layer over that system: no routes, forms, services, permissions, or stored config. It works through three hooks in `better_local_tasks.module` — one attaches its CSS library, one repoints the `block__local_tasks_block` and `menu_local_tasks` theme hooks at bundled Twig overrides, and one tags each tab with a semantic CSS class (`view`, `edit`, `delete`, `revisions`, `translate`, `devel`, `shortcuts`) so the stylesheet can attach an SVG icon. The styling is deliberately scoped: it is applied only on non-admin routes and only for users who hold the core `access contextual links` permission, so anonymous visitors and admin-theme pages keep the default tabs. There is no configuration screen and nothing to set via drush or PHP — enabling the module is the whole setup, and the look is changed by overriding its templates and CSS in your own theme. Because the CSS uses hard-coded fixed positioning and dark colours, the main thing to verify is that the panel agrees with your front-end theme's markup and layout.

---

- Restyle local task tabs into a slide-out panel.
- Give the View / Edit / Delete tabs icons.
- Fix the tab strip to the edge of the screen.
- Free up horizontal space taken by the default tabs.
- Add hover animation to the local tasks block.
- Keep tab behaviour unchanged while changing the look.
- Show tabs only to editors (users with contextual links).
- Leave the admin theme's tabs untouched.
- Apply a consistent tab style across the front end.
- Override the local-tasks block template site-wide.
- Override the menu-local-tasks template site-wide.
- Tag tabs with semantic classes for theming.
- Attach SVG icons to standard entity operations.
- Style revision, translate, and devel tabs distinctly.
- Provide a modern tab UI without writing CSS yourself.
- Base a custom tab restyle on the bundled templates.
- Reduce visual clutter on narrow screens.
- Polish the front-end editorial experience.
- Enable a tab restyle with zero configuration.
- Disable it cleanly by uninstalling the module.
- Scope the restyle by overriding its CSS in a subtheme.
- Improve discoverability of entity operations via icons.
