<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Button Formatter (button_formatter) — agent index

Adds a field formatter (plugin id `button_formatter`, label "Button") that renders **link** and
**file** fields as a styled anchor (a button) instead of a plain link. A site-wide settings form
defines the available button-style classes; each field display then picks one. Core-only, no
external dependencies. `core_version_requirement: ^10 || ^11` (release packaged as `8.x-1.8`).

- **The formatter itself — field types, per-display settings, how it builds the button** →
  [fields/formatter.md](fields/formatter.md)
- **The site settings form: style/size/radius vocabularies + `global_class`** →
  [configure/settings.md](configure/settings.md)
- **The single permission** → [permissions/permissions.md](permissions/permissions.md)
- **Overriding the button markup** → [theme/button-link.md](theme/button-link.md)

Key facts:
- Formatter plugin: `Drupal\button_formatter\Plugin\Field\FieldFormatter\ButtonFormatter`
  (`@FieldFormatter id = "button_formatter"`), `field_types = {"file", "link"}`.
- Settings route/form: `button_formatter.settings` → `/admin/config/button-formatter`
  (`Drupal\button_formatter\Form\ButtonFormatterSettings`), gated by permission
  `administer button formatter` (`restrict access: true`).
- Config object `button_formatter.settings`: `global_class` (string), `styles`, `sizes`, `radius`
  (each a list of `class|Label` strings). Install defaults are Bootstrap `btn-*` classes.
- Per-display formatter settings schema: `field.formatter.settings.button_formatter`
  (keys `style`, `show_icon`, `icon`, `download`, `new_tab`, `show_custom_label`, `custom_label`,
  `show_description`, `size`, `radius`).
- Theme hook `button_link` → `templates/button-link.html.twig` (renders `{{ button }}`).
- No Drush commands, no services, no hook implementations beyond `hook_help` and `hook_theme`,
  and it defines no plugin type of its own.
