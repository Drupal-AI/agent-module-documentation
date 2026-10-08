<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Heading — agent index

Provides a `heading` field type (text + size h1–h6) rendered as a real heading element, plus a
`heading_text` formatter for existing string/text fields. Depends on core `field`. No admin
settings page, no permissions, no Drush, no configure route (`configure: null`). Config schema
provided.

- **The `heading` field type, `heading` widget & `heading` formatter (columns, sizes, allowed_sizes)** →
  [plugins/heading-field.md](plugins/heading-field.md)
- **Render an existing string/text field as a heading with the `heading_text` formatter (`size` setting)** →
  [configure/heading-text-formatter.md](configure/heading-text-formatter.md)

Key facts: field type id `heading` (`HeadingItem`) — columns `text` (varchar 255) + `size`
(char 2); default widget `heading`, default formatter `heading` (theme hook `heading`,
template `heading.html.twig` → `<{{size}}>{{text}}</{{size}}>`); field settings `label` and
`allowed_sizes` (subset of h1–h6). Second formatter `heading_text` targets `string`/`text`
fields with a `size` setting (default `h2`). Also adds `size`/`text` tokens per heading field
via `hook_token_info_alter()`.
