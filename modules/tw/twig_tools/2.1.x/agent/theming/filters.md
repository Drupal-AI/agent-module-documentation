<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Tools filter reference

All are Twig **filters** (`{{ value|name }}`), registered by three `twig.extension` services. All
implementations are static methods on the extension class (`src/TwigExtension/*.php`). No config.

## Sanitize — `twig_tools_sanitize.twig.extension` (TwigSanitize)

| Filter | Signature | Behavior |
|---|---|---|
| `clean_class_array` | `array → array` | Maps each item through `Html::getClass()` → valid CSS class names. |
| `array_unique` | `array → array` | Removes duplicate values (re-indexed). |
| `remove_empty` | `array → array` | Removes falsy/empty values (`array_filter`, re-indexed). |
| `scrub_class_array` | `array → array` | Runs `clean_class_array` + `remove_empty` + `array_unique` in one pass. |

```twig
<div class="{{ ['Card', 'card--Blue', '', 'Card']|scrub_class_array|join(' ') }}">
{# => class="card card--blue" #}
```

## Convert — `twig_tools_convert.twig.extension` (TwigConvert)

| Filter | Signature | Behavior |
|---|---|---|
| `boolean` | `mixed → bool` | `boolval($value)`. |
| `integer` | `mixed → int` | `intval($value)`. |
| `float` | `mixed → float` | `floatval($value)`. |
| `string` | `mixed → string` | `strval($value)`. |
| `md5` | `mixed → string` | `md5(strval($value))`. |
| `json_decode` | `string[, bool assoc=?] → array\|object` | `json_decode($value, $assoc)`. |
| `date_from_format` | `string value, string from_format, string to_format[, ?from_tz, ?to_tz] → string` | `DateTime::createFromFormat($from_format, $value[, $from_tz])`, optional `setTimezone($to_tz)`, then `format($to_format)`. Empty non-`'0'` value → `''`. |
| `base64_encode` | `string → string` | `base64_encode($value)` (empty → `''`). |
| `base64_decode` | `string[, bool strict=?] → string\|false` | `base64_decode($value, $strict)` (empty → `''`). |

```twig
{{ '2024-01-15'|date_from_format('Y-m-d', 'd/m/Y') }}   {# => 15/01/2024 #}
{{ 'Drupal'|base64_encode }}                              {# => RHJ1cGFs #}
{% set data = node.field_json.value|json_decode(true) %}
```

## Color — `twig_tools_color.twig.extension` (TwigColor)

| Filter | Signature | Behavior |
|---|---|---|
| `rgb_to_hex` | `[r,g,b] → string` | `#rrggbb`; validates each 0–255; returns nothing if not exactly 3 valid values. |
| `css_rgb_to_hex` | `string → string` | Parses `rgb(r,g,b)` (0–255 each) then `rgb_to_hex`. |
| `hex_to_rgb` | `string → [r,g,b]` | Accepts `#rrggbb` or shorthand `#rgb`; returns integer RGB array. |
| `hex_to_css_rgb` | `string → string` | `hex_to_rgb` then `rgb(r, g, b)` (note the spaces after commas). |

```twig
{{ [51, 102, 204]|rgb_to_hex }}        {# => #3366cc #}
{{ '#3366cc'|hex_to_css_rgb }}          {# => rgb(51, 102, 204) #}
{{ '#f00'|hex_to_rgb|join(',') }}       {# => 255,0,0 #}
```

## Notes

- Enabling the module registers all filters globally; no configuration is involved.
- Filters return "nothing"/empty on invalid input (e.g. `rgb_to_hex` with out-of-range values,
  `hex_to_rgb` with a non-hex string) rather than throwing.
- To confirm a filter is available on a running site:
  `\Drupal::service('twig')->getFilter('hex_to_css_rgb')` (non-null when present), or render an
  inline template: `\Drupal::service('twig')->createTemplate("{{ '#3366cc'|hex_to_css_rgb }}")->render()`.
