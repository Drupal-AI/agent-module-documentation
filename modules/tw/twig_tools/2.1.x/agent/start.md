<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Tools — agent index

Adds extra **Twig filters** (17, across 3 extensions) for sanitizing class arrays, converting
values, and converting colors. **No config, routes, permissions, plugins, schema, or Drush** —
enabling the module makes the filters available in every Twig template.

- **The full filter reference (names, extensions, behavior, examples)** →
  [theming/filters.md](theming/filters.md)

Key facts:
- Extensions (all `twig.extension`-tagged, static methods):
  - `twig_tools_sanitize.twig.extension` (TwigSanitize): `clean_class_array`, `scrub_class_array`,
    `array_unique`, `remove_empty`.
  - `twig_tools_convert.twig.extension` (TwigConvert): `boolean`, `integer`, `float`, `string`,
    `md5`, `json_decode`, `date_from_format`, `base64_encode`, `base64_decode`.
  - `twig_tools_color.twig.extension` (TwigColor): `rgb_to_hex`, `css_rgb_to_hex`, `hex_to_rgb`,
    `hex_to_css_rgb`.
- All are **filters** (`new TwigFilter(...)`), used as `{{ value|filter_name }}`.
- Check availability live: `\Drupal::service('twig')->getFilter('hex_to_css_rgb')`.
