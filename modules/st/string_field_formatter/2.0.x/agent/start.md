<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# String Field Formatter — agent index

Adds one field formatter, **`plain_string_formatter`** ("Plain string formatter"), for
`string` and `string_long` fields. It wraps the field output in a chosen HTML tag with custom
classes. No settings form of its own, no configure route, no permissions, no Drush.

- **Use/configure the formatter (settings, where stored, drush)** →
  [plugins/plain-string-formatter.md](plugins/plain-string-formatter.md)

Key facts:
- Formatter id **`plain_string_formatter`**, class `PlainStringFormatter extends StringFormatter`,
  field types `string` and `string_long`.
- Two extra settings: **`wrap_tag`** (select; default `_none` = no wrapper; options h1-h6, p,
  blockquote, pre, span, div, code, em, strong, time, … ) and **`wrap_class`** (space/comma
  separated CSS classes). Also inherits core `link_to_entity`.
- Stored on the field's component in the `entity_view_display` config entity; schema
  `field.formatter.settings.plain_string_formatter` (extends `field.formatter.settings.string`).
