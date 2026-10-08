# color — agent start

Lets admins recolor **compatible** themes via a color picker on the theme settings page
(**Admin → Appearance → Settings → *theme***, `system.theme_settings_theme`). No config route
of its own (`configure: null`); it hooks `hook_form_system_theme_settings_alter`. Requires PHP
**GD** (PNG). Palette + generated files live in `color.theme.<theme>` config. No permissions,
routes, drush, plugin types, or `.api.php` of its own.

- Change/store a theme's colors, config objects & schema → [configure/color-scheme.md](configure/color-scheme.md)
- Make a theme color-compatible (`color.inc`, preview, template) → [theming/compatible-theme.md](theming/compatible-theme.md)
