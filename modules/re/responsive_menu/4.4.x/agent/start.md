<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# responsive_menu — agent start

Renders a Drupal menu as an mmenu **off-canvas** mobile menu (burger toggle) and as a
**horizontal** drop-down menu at wider widths, switching at a theme breakpoint. All behaviour
lives in the single config object `responsive_menu.settings`. Config UI: **Admin → Config →
User interface → Responsive menu** (`/admin/config/user-interface/responsive-menu`, route
`responsive_menu.settings`, permission `administer site configuration`). Provides two blocks:
`responsive_menu_toggle` (mobile icon) and `responsive_menu_horizontal_menu` (horizontal menu).
Requires the **mmenu** JS library in `/libraries/mmenu`; no plugin types, permissions, or Drush.

- Settings keys, choosing menus, breakpoints, off-canvas options, drush cget/cset → [configure/settings.md](configure/settings.md)
- Blocks, templates, CSS overrides, and the `hook_responsive_menu_*_alter` hooks → [theming/theming.md](theming/theming.md)
