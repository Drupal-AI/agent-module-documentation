<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Responsive menu renders any Drupal menu as a javascript off-canvas ("hamburger") mobile menu using the mmenu library, and as a horizontal drop-down/flyout menu at wider screen widths. A configurable theme breakpoint controls the switch between the two.

---

The module ships two blocks — a "Responsive menu mobile icon" toggle (burger) and a "Horizontal menu" block — plus a single settings form at `/admin/config/user-interface/responsive-menu`. All behaviour is driven by the `responsive_menu.settings` config object: you pick which menu becomes the horizontal menu (`horizontal_menu`) and which menu(s) feed the off-canvas panel (`off_canvas_menus`, comma-delimited so several menus can merge), then choose a theme breakpoint (`horizontal_breakpoint` / `horizontal_media_query`) at which the mobile icon hides and the horizontal menu appears. The off-canvas panel is themeable (light/dark/black/white), can slide from the left, right, or contextually by language direction, and can dim the page behind it. Optional enhancements include the Superfish library for better hover/flyout support on the horizontal menu, a drag/swipe-to-open gesture, IE11 polyfills, Bootstrap-navbar compatibility, and page-wrapper divs for themes (admin or front end) that lack a single wrapping element. The mmenu JS library must be installed to `/libraries/mmenu` (via npm or manual download); Superfish is a separate optional download. Menu selection and tree building can be altered programmatically through several `hook_responsive_menu_*_alter` hooks. The module requires no library beyond mmenu and defines no plugin types, permissions, or Drush commands.

---

- Add a mobile-friendly off-canvas "hamburger" menu that slides in over the page
- Show a horizontal drop-down menu on desktop and switch to the off-canvas menu on mobile
- Merge a main menu and a utility menu into a single mobile menu at small screen sizes
- Trigger the desktop/mobile switch at a specific theme breakpoint (e.g. min-width 1000px)
- Serve the mobile menu at every screen size by disabling the breakpoint entirely
- Render deep, multi-level menu structures with drill-down navigation on mobile
- Limit the horizontal menu to a single row by capping its display depth
- Slide the mobile panel out from the left, the right, or contextually per language direction
- Style the off-canvas panel with a light, dark, black, or white mmenu theme
- Dim the page (to page colour, white, or black) when the mobile menu opens
- Add a swipe/drag gesture so mobile users can open the menu by dragging
- Enhance the horizontal menu with Superfish hover intent, flyouts, and timing controls
- Allow the responsive menu to appear on admin-theme pages, not just the front-end theme
- Inject a page-wrapper div for themes (Bootstrap, admin themes) that lack one, as mmenu requires
- Make a Bootstrap 4 navbar's menu icon open the off-canvas menu instead of the navbar collapse
- Support IE11 by loading the mmenu polyfills
- Disable the module's bundled CSS so you can style the menu entirely from your theme
- Fix Chrome mobile viewport rendering by dynamically rewriting the viewport meta tag on open
- Swap which menu is used per page/section with `hook_responsive_menu_*_menu_names_alter`
- Alter the rendered menu tree (titles, items) before display via tree-alter hooks
- Conditionally suppress the off-canvas menu on certain pages/themes via the output-alter hook
- Add custom menu-tree manipulators to filter or reorder items before rendering
- Provide accessible keyboard navigation and a toggle icon for the mobile menu
