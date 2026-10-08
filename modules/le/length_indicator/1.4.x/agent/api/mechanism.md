<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Length Indicator works

Pure hook-driven widget enhancement in `length_indicator.module`. No plugins, no entities.

## Supported widgets

`_length_indicator_widget_is_supported($widget_id)` returns TRUE only for:

- `string_textfield` (Textfield)
- `string_textarea` (Text area, multiple rows)

Every hook below early-returns for any other widget, so the option never appears on, e.g.,
`text_textarea`, `datetime_default`, or entity-reference widgets.

## Hooks

| Hook | Role |
|---|---|
| `hook_field_widget_third_party_settings_form()` | Adds the **Length indicator** checkbox and the `optimin` / `optimax` / `tolerance` number fields to the widget's settings on *Manage form display*. Validators `_length_indicator_settings_optimax` (optimax > optimin) and `_length_indicator_settings_tolerance` (tolerance < optimin). |
| `hook_field_widget_settings_summary_alter()` | Appends `Length indicator: On`/`Off` to the widget summary. |
| `hook_field_widget_single_element_form_alter()` | When `indicator` is on: attaches the `length_indicator/length_indicator` library; adds `data-length-indicator-total` (= `optimin + optimax`) and the marker attribute `length-indicator-enabled` to the input; renders a `length_indicator` themed element built from the geometry service. |
| `hook_theme()` | Declares the `length_indicator` theme hook (`templates/length-indicator.html.twig`, variable `indicators`). |

## Geometry service

`length_indicator.get_width_pos` → `Drupal\length_indicator\GetWidthPos`.

```php
$indicators = \Drupal::service('length_indicator.get_width_pos')
  ->getWidthAndPosition($optimin, $optimax, $tolerance);
```

Returns an ordered 5-segment array (indices 0–4) each with `width` (percent), `pos`
(character offset), and `class`:

- `length-indicator__indicator--bad` (0 → too short, and the trailing too-long segment)
- `length-indicator__indicator--ok`  (amber tolerance bands on each side)
- `length-indicator__indicator--good` (the `optimin`–`optimax` sweet spot)

Boundaries: `min = optimin - tolerance`, `max = optimax + tolerance`,
`total = max + min`; widths are cumulative percentages of `total`. The JS
(`js/length-indicator.js`, depends on `core/once`) reads the input length live and moves the
marker over these segments. The whole thing is an editing aid only — it does not alter the
stored value, validation, or display formatter.
