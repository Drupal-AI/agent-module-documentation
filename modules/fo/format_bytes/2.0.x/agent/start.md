<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Format Bytes — agent index

Registers **one Twig filter, `format_bytes`**, that formats a raw byte count into a
human-readable size string. No config, no UI, no permissions, no Drush, no schema, no
plugins. Its only public surface is the filter.

- **Use the `format_bytes` Twig filter (and what it maps to)** →
  [theming/format-bytes-filter.md](theming/format-bytes-filter.md)

Key fact: the service `format_bytes.twig_extension`
(`Drupal\format_bytes\Twig\ByteConversionTwigExtension`) is tagged `twig.extension` and its
sole filter `format_bytes` delegates straight to core
`Drupal\Core\StringTranslation\ByteSizeMarkup::create()`. So `{{ 1073741824|format_bytes }}`
renders "1 GB". Nothing is stored or configured; it is a render-time formatter only.
