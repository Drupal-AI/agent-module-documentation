<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Tools adds a set of extra Twig filters to Drupal's theme layer — for sanitizing class arrays, converting values (booleans, numbers, strings, dates, base64, JSON), and converting colors between hex and RGB — so themers can do these transformations directly in templates without preprocess code.

---

The module registers three `twig.extension`-tagged services, each an `AbstractExtension`
providing filters: **TwigSanitize** (`twig_tools_sanitize.twig.extension`) with `clean_class_array`,
`scrub_class_array`, `array_unique`, `remove_empty`; **TwigConvert**
(`twig_tools_convert.twig.extension`) with `boolean`, `integer`, `float`, `string`, `md5`,
`json_decode`, `date_from_format`, `base64_encode`, `base64_decode`; and **TwigColor**
(`twig_tools_color.twig.extension`) with `rgb_to_hex`, `css_rgb_to_hex`, `hex_to_rgb`,
`hex_to_css_rgb`. All are implemented as static methods on those extension classes. There is **no
configuration, no routes, no permissions, no plugins, and no schema** — enabling the module makes
the filters available in every Twig template site-wide. The class-array filters use Drupal's
`Html::getClass()` to produce valid CSS class names and strip empty/duplicate values; the convert
filters wrap PHP's `boolval`/`intval`/`floatval`/`strval`/`md5`/`json_decode`/`base64_*` and a
`DateTime::createFromFormat`-based reformatter with optional timezones; the color filters convert
between `[r,g,b]` arrays, `#rrggbb` hex (also 3-char shorthand), and `rgb(r, g, b)` CSS strings.

---

- Sanitize a dynamic list of CSS classes into valid class names in a template (`clean_class_array`).
- Remove empty/falsy values from a classes array before printing (`remove_empty`).
- De-duplicate a classes array so a class isn't emitted twice (`array_unique`).
- Do all three at once (clean + de-dupe + remove empty) with `scrub_class_array`.
- Convert a field value to a real boolean for a Twig `if` test (`boolean`).
- Cast a string to an integer or float for arithmetic in a template (`integer`, `float`).
- Turn a value into a string explicitly (`string`).
- Hash a value to an MD5 string in Twig (e.g. for a Gravatar URL) (`md5`).
- Decode a JSON string stored in a field into an array/object (`json_decode`).
- Reformat a date string from one format to another, with timezone conversion (`date_from_format`).
- Base64-encode a value for a data URI or token (`base64_encode`).
- Base64-decode an encoded value in a template (`base64_decode`).
- Convert an `[r,g,b]` array to a `#rrggbb` hex color (`rgb_to_hex`).
- Convert a `rgb(12,34,56)` CSS string to hex (`css_rgb_to_hex`).
- Convert a `#rrggbb` (or shorthand `#rgb`) hex to an `[r,g,b]` array (`hex_to_rgb`).
- Convert a hex color to a `rgb(r, g, b)` CSS string (`hex_to_css_rgb`).
- Build inline color styles from a theme setting's hex value in a template.
- Normalize user-entered class strings into safe HTML class attributes.
- Avoid writing a preprocess hook just to transform a value for display.
- Compute derived display values entirely in the presentation layer.
- Keep small data conversions with the markup that uses them for readability.
