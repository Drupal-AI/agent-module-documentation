<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Menus — agent index

Makes existing Drupal menus mobile-friendly by attaching a JS "style" (plugin) to CSS/jQuery
selectors. Does not create menus. One active style at a time, configured globally.

- **Settings form, config object (`responsive_menus.configuration`), choosing a style + its settings** →
  [configure/settings.md](configure/settings.md)
- **The `@ResponsiveMenus` plugin type: shipped styles and how to add one** →
  [plugins/styles.md](plugins/styles.md)
- **Legacy/alter hooks (`hook_responsive_menus_style_info`, `_styles_alter`, `_execute`)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Configure route: `responsive_menus.admin` → `/admin/config/user-interface/responsive_menus`.
- Permission: `administer responsive menus`.
- Config object `responsive_menus.configuration`: `style` (default `responsive_menus_simple`),
  `ignore_admin` (default true), `style_settings` (per-style map).
- Plugin manager service: `plugin.manager.responsive_menus`; plugins live in
  `Plugin/ResponsiveMenus/` with the `@ResponsiveMenus` annotation.
- Shipped/enabled styles: `responsive_menus_simple`, `mean_menu`. Others (Sidr, codrops, Google
  Nexus, Multi-level Push Menu) need external libraries downloaded.
