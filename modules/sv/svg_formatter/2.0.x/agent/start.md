<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Formatter — agent index

One field formatter (`svg_formatter`, label **"SVG Formatter"**) that renders SVG files from a
**File** field as `<img>` or as sanitized inline `<svg>`. No settings form, no configure route
(`configure: null`), no permissions, no Drush, no services, no plugin types. All state lives in
`core.entity_view_display.*` formatter settings.

- **Field setup, the nine settings, storage location, drush/PHP recipes** →
  [configure/svg-field.md](configure/svg-field.md)
- **Theme hook, template, inline/DOM handling, sanitizer & accessibility** →
  [theming/output.md](theming/output.md)

Key facts:
- Applies to `file` and `image` fields; on `image` fields it is only offered when the contrib
  module **`svg_image`** is enabled (`isApplicable()`).
- Items whose MIME type is not `image/svg+xml` are silently skipped.
- Settings: `inline`, `sanitize`, `apply_dimensions`, `width` (100), `height` (100),
  `enable_alt` (TRUE), `alt_string`, `enable_title` (TRUE), `title_string`.
- Inline sanitizing needs the Composer library **`enshrined/svg-sanitize`** (a hard `require` of
  the module); without it the checkbox is disabled.
- Config schema key: `field.formatter.settings.svg_formatter`.
