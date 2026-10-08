Accessible Menu Bootstrap 5 adds a Bootstrap 5 styled, accessible menu library variant (navbar markup plus an "Expand at" breakpoint) to the Accessible Menu module.

---

This submodule of Accessible Menu registers a second menu-library plugin, `accessible_menu_bootstrap_5`, that maps the module's four menu types (Disclosure Menu, Menubar, Top Link Disclosure Menu, Treeview) onto the `Bootstrap5*` constructors exported by the accessible-menu-bootstrap-5 JavaScript package. It ships Bootstrap navbar Twig templates, sets Bootstrap-appropriate default classes (`collapse` / `collapsing`, transition duration 350ms) when you pick a Bootstrap menu type, and adds an "Expand at" select (xs–xl) so a collapsible menu becomes a responsive navbar that expands at the chosen breakpoint. At render time it adds `navbar` / `navbar-expand-*` classes to the menu block and points the JS at Bootstrap's `.navbar-nav`, `.navbar-toggler`, and `.navbar-collapse` selectors. It requires the parent `accessible_menu` module, and you must supply Bootstrap 5's own CSS/JS from your theme.

---

- Turn a core menu into an accessible Bootstrap 5 navbar without custom JavaScript.
- Reuse Bootstrap's navbar markup (`navbar`, `navbar-nav`, `navbar-toggler`, `navbar-collapse`) with correct ARIA behaviour.
- Choose a Bootstrap-flavoured Disclosure Menu, Menubar, Top Link Disclosure Menu, or Treeview.
- Make the navbar collapse into a toggler on small screens and expand at a chosen breakpoint.
- Set the "Expand at" breakpoint to xs, sm, md, lg (default), or xl.
- Get Bootstrap-correct default open/close/transition classes (`collapse`, `collapsing`) applied automatically when selecting a Bootstrap menu type.
- Provide dropdown submenus styled with Bootstrap's `dropdown` / `dropdown-menu` / `dropdown-toggle` classes.
- Serve the Bootstrap 5 accessible-menu assets from jsDelivr, unpkg, or a local /libraries copy.
- Pin the Bootstrap 5 library to a specific semver version or track "latest".
- Enable optional-key support for Bootstrap disclosure and top-link disclosure menus.
- Combine with your existing Bootstrap 5 theme so menus match the site's design system.
- Automatically remove Bootstrap 5 menu configuration on uninstall (menus using it are cleaned up).
- Override the Bootstrap navbar templates via the submodule's theme hooks for bespoke markup.
