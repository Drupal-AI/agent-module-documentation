<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Class Formatter — agent index

One field formatter (`entity_class_formatter`, label **"Entity Class"**) that outputs nothing
and instead pushes the field's values onto the rendered **entity wrapper's** `#attributes`.
No settings form, no configure route (`configure: null`), no permissions, no Drush, no services,
no plugin types. All state lives in `core.entity_view_display.*` components.

- **Assign the formatter, its four settings, where they are stored, drush/PHP recipes** →
  [configure/apply-class.md](configure/apply-class.md)
- **How values become classes/attributes (hook, extraction rules, Layout Builder)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Supported field types: `boolean`, `decimal`, `entity_reference`, `float`, `integer`,
  `list_string`, `string`.
- Settings: `prefix`, `suffix`, `attr` (default `class`), `field` (entity-reference only).
- `attr` is **required** for `decimal` / `float` / `integer` fields.
- Stored at `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type: entity_class_formatter` with `settings: {prefix, suffix, attr, field}`.
