<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Sanitizer — agent index

A single field formatter that renders SVG files inline after cleaning them with the
`enshrined/svg-sanitize` library. No global config (`configure` null), no permissions, no Drush,
no plugin types it defines. Depends only on the external Composer library.

- **The `svg_sanitizer` formatter, its settings, allow-list extension, and the sanitize pipeline** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `svg_sanitizer`, field types `file`, `svg_icon`, `svg_image_field`
  (`src/Plugin/Field/FieldFormatter/SvgSanitizer.php`).
- Per-formatter settings `allowedtags`, `allowedattrs` (comma-separated) extend the library
  defaults via `SvgSanitizerTags` / `SvgSanitizerAttributes`. Schema
  `field.formatter.settings.svg_sanitizer`.
- Sanitization happens **only at display time** where this formatter is selected — there is no
  upload hook; unsanitized formatters bypass it. Output emitted with `Markup::create()` (inline SVG).
