Accessible Menu attaches the accessible-menu JavaScript library to core menu blocks so they become WCAG/WAI-ARIA keyboard-navigable, configured per menu.

---

Accessible Menu integrates the third-party accessible-menu library (NickDJM/accessible-menu) into Drupal so that any core menu block can be turned into a fully accessible interactive menu — with ARIA roles, arrow-key navigation, and focus/hover handling — from the admin UI. Each menu is configured on its normal edit form (Structure → Menus): pick a menu type (Disclosure Menu, Menubar, Top Link Disclosure Menu, or Treeview), optionally make it collapsible, and tune the open/close/transition CSS classes, transition and hover timing, and optional key support. A site-wide settings page controls how the library assets are delivered — an external CDN (jsDelivr or unpkg, at a chosen semver version or "latest") or a locally installed copy under /libraries. The module adds the behaviour, the ARIA attributes, and Twig template overrides only; it intentionally ships no CSS, leaving visual styling to your theme. The Bootstrap 5 submodule adds a Bootstrap-styled library variant and navbar-oriented templates, plus an "Expand at" breakpoint setting.

---

- Make a core navigation menu keyboard-accessible (arrow keys, Home/End, Escape) without writing JavaScript.
- Add correct WAI-ARIA roles and states to an existing site menu to improve WCAG compliance.
- Turn a primary navigation menu block into an ARIA menubar.
- Render a menu as a disclosure menu where submenus expand/collapse on activation.
- Use a Top Link Disclosure Menu so a parent link is both clickable and a submenu toggle.
- Present a nested menu as an ARIA treeview.
- Make a menu collapsible behind a hamburger/toggle button on small screens.
- Configure the CSS class applied when a submenu is open (default `show`).
- Configure the CSS class applied when a submenu is closed (default `hide`).
- Configure a transition class and transition duration for open/close animations.
- Set separate open and close durations independent of the base transition duration.
- Enable hover-to-open behaviour, with "on" or "dynamic" modes and configurable hover/enter/leave delays.
- Enable optional-key support for disclosure and top-link disclosure menus.
- Choose whether the accessible-menu assets load from the jsDelivr CDN or unpkg.
- Pin the library to a specific semantic version, or track "latest".
- Serve the library from a local /libraries install instead of a CDN for offline or CSP-restricted sites.
- Provide your own theme CSS to style the accessible markup to match your design.
- Override the menu Twig templates via the module's theme suggestions (per menu machine name, type, or both).
- Apply Bootstrap 5 navbar markup and behaviour to a menu using the accessible_menu_bootstrap_5 submodule.
- Set the responsive breakpoint (`xs`–`xl`) at which a Bootstrap 5 collapsible menu expands.
- Automatically clean up a menu's accessible-menu configuration when the menu entity is deleted.
- Extend the system with a custom library by implementing a new `AccessibleMenuLibrary` plugin.
