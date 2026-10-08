# Enhanced Button Link — agent index

Widget + formatter that render core `link` fields as Bootstrap buttons (style/size/status/target),
with a global styles list and per-link overrides. Depends on core `link`; needs a Bootstrap theme
for looks. No permissions or config schema of its own.

- **Global settings form, config keys, the widget & formatter, and per-link overrides** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Formatter `enhanced_button_link_formatter` (extends `LinkFormatter`); widget
  `enhanced_button_link_widget` (extends `LinkWidget`); both for field type `link`.
- Settings form route `enhanced_button_link.admin_settings` →
  `/admin/config/content/enhanced-button-link` (`_permission: 'administer site configuration'`),
  config object `enhanced_button_link.settings` (defaults in `config/install/`).
- Set the widget on *Manage form display* and the formatter on *Manage display* for a link field.
