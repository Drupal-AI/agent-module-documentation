<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Responsive Menus turns any existing Drupal menu into a mobile-friendly menu by attaching a JavaScript "style" (Simple, MeanMenu, and other downloadable ones) to CSS/jQuery selectors you specify, swapping in a toggle button below a chosen screen width.

---

The module does not build menus; it "responsifies" whatever markup your theme already renders. You pick one **style** (a Responsive Menus plugin) on the settings form at `/admin/config/user-interface/responsive_menus` and give it CSS/jQuery selectors for the menu(s) to transform, the toggle text/HTML, and the breakpoint width. The active style, the "ignore admin pages" flag, and the style's own settings are stored in config object `responsive_menus.configuration` (`style`, `ignore_admin`, `style_settings`). On every non-excluded page, `hook_page_attachments()` instantiates the chosen style plugin, attaches its JS/CSS library, and passes the plugin's `getJsSettings()` into `drupalSettings.responsive_menus`. Styles are plugins under `Plugin/ResponsiveMenus/` annotated with `@ResponsiveMenus` (managed by `plugin.manager.responsive_menus`); two ship enabled — **Simple expanding** (`responsive_menus_simple`, the default) and **Mean Menu** (`mean_menu`) — while Sidr, codrops Multi-level and Google Nexus, and Multi-level Push Menu require you to download their libraries. New styles are added by defining a plugin (or, legacy path, `hook_responsive_menus_style_info()`), and existing styles can be reshaped with the `hook_responsive_menus_styles_alter()` plugin-definition alter hook. A single permission, `administer responsive menus`, gates the settings form. Per the README it can also be driven as a Context reaction.

---

- Make a theme's main navigation collapse into a hamburger/toggle on small screens.
- Turn a footer or secondary menu into a mobile-friendly menu without theme code.
- Choose the breakpoint width (e.g. 768px) at which the menu switches to mobile mode.
- Point the module at a specific menu using a CSS/jQuery selector (e.g. `#main-menu`, `.menu`).
- Responsify several menus at once by listing multiple selectors (comma- or line-separated).
- Set custom toggle button text or HTML (e.g. `☰ Menu`, or spans for a bar icon).
- Use the lightweight "Simple expanding" style for a zero-dependency mobile menu.
- Use the MeanMenu style for multi-level mobile menus with expand/collapse controls.
- Position the open/close controls left, right, or center (MeanMenu).
- Open the mobile menu with absolute positioning (overlay) or push the page down (Simple).
- Disable hover drop-downs while in mobile mode to avoid double-tap issues.
- Temporarily strip other classes/IDs on the menu so mobile styling applies cleanly.
- Exclude admin pages from responsive behavior with the "ignore admin pages" option.
- Switch the width unit between px and em for the breakpoint (Simple).
- Attach a downloadable style (Sidr, Google Nexus, codrops) once its library is installed.
- Define your own responsive menu style as a `@ResponsiveMenus` plugin.
- Alter or bypass a shipped style's library requirements with `hook_responsive_menus_styles_alter()`.
- Configure everything through exported config (`responsive_menus.configuration`) for deployment.
- Drive responsive menus as a Context module reaction with the same options.
- Provide a consistent mobile navigation experience across a multi-theme site.
