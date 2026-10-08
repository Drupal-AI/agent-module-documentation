<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `numeric_color_scale` Views field handler

## Install & enable

```bash
composer require drupal/views_color_scales
drush en views_color_scales -y
```

Only dependency is core **`views`**. No submodules, no permissions, no Drush, no config form.

## How it attaches (no new field)

`views_color_scales_views_data_alter()` (in `views_color_scales.module`) walks all Views data and,
for every field definition with `field.id === 'numeric'`, sets it to **`numeric_color_scale`**.
So the handler `NumericColorScale` (`src/Plugin/views/field/NumericColorScale.php`,
`#[ViewsField("numeric_color_scale")]`, extends core `NumericField`) **replaces** the standard
numeric handler everywhere. You do not add a special field — you just edit an existing numeric
field in a View and new *Color Scale* options appear. With coloring left off, the field renders
exactly like core's numeric field.

## Enabling it in the UI

*Structure → Views → (edit view)* → click a numeric field → in the field settings:

1. Check **Enable Color Scale**.
2. Leave **Auto-detect min/max values** on (default) to scale colors to the current result set, or
   uncheck it and enter **Minimum Value** / **Maximum Value** (number, step 0.01).
3. Open **Color Configuration** to set **Minimum Value Color** and **Maximum Value Color**
   (HTML color inputs).

## Options (`defineOptions()`)

| Option key | Type | Default | Meaning |
|---|---|---|---|
| `color_scale` | boolean | `FALSE` | Master on/off for this field. |
| `color_scale_auto` | boolean | `TRUE` | Derive the interpolation min/max from the current result set. |
| `color_scale_min` | string | `'0'` | Manual minimum (used when auto is off). |
| `color_scale_max` | string | `'100'` | Manual maximum (used when auto is off). |
| `color_scale_min_color` | color hex | `#FFB3B3` | Color for the lowest value. |
| `color_scale_max_color` | color hex | `#B3FFB3` | Color for the highest value. |

Schema: `config/schema/views_color_scales.views.schema.yml` (`views.field.numeric_color_scale`
extends `views.field.numeric`; the two colors use core type `color_hex`). The form fields are
gated with `#states`: the min/max number fields only show when coloring is on **and** auto is off;
the color details and auto checkbox only show when coloring is on.

## Render logic (`render()`)

```
$value    = $this->getValue($values);
$rendered = parent::render($values);   // core numeric formatting (precision, prefix/suffix, …)
```

- If `color_scale` is off, or the value is hidden-empty (`hide_empty` + empty + not a shown zero),
  it returns `$rendered` unchanged.
- Interpolation range: auto → `getAutoMinMax()` (min/max over all `is_numeric` values in
  `$this->view->result`; falls back to 0/1 when none); manual → `(float) color_scale_min/max`.
  If min == max it bumps max by 1 to avoid divide-by-zero.
- `calculateColor((float) $value, $colorMin, $colorMax)` clamps the value into the range, computes
  `position = (value - min) / (max - min)`, converts both configured colors to RGB with
  `hexToRgb()`, linearly interpolates each channel, and returns `sprintf('#%02X%02X%02X', …)` —
  **always a well-formed hex string**, never raw config text.
- `getContrastColor($bg)` returns `'black'` or `'white'` from luminance
  `(r*299 + g*587 + b*114)/1000` (> 128 → black).
- A gauge `position` for the popover is computed separately from the **manual** min/max
  (`color_scale_min`/`max`), clamped and rounded to 4 dp.

The result is rendered via the SDC component (see [../api/popover.md](../api/popover.md)):

```php
$build = [
  '#type' => 'component',
  '#component' => 'views_color_scales:scale_popover',
  '#props' => [
    'has_popover' => !empty($popover_content),
    'value'       => (float) $value,
    'bg_color'    => $backgroundColor,   // "#RRGGBB"
    'text_color'  => $textColor,         // "black" | "white"
    'popover_id'  => Html::getUniqueId('vcs-popover'),
  ],
  '#slots' => ['display_value' => $rendered, /* + 'content' if a hook filled it */],
];
return $this->getRenderer()->render($build);
```

## Config export example (view display field)

```yaml
# in a views.view.* display, under display.<id>.display_options.fields.<field>
field_score:
  id: field_score
  table: node__field_score
  field: field_score
  plugin_id: numeric_color_scale
  precision: 0
  color_scale: true
  color_scale_auto: false
  color_scale_min: '0'
  color_scale_max: '10'
  color_scale_min_color: '#FFB3B3'
  color_scale_max_color: '#2ECC71'
```

## Operating notes

- **Auto min/max is per result page** (it reads `$this->view->result`), so identical values can
  color differently across pages/exposed-filter states. Use manual min/max for stable thresholds
  and cross-View consistency.
- Because it subclasses `NumericField`, precision/decimals/separator/prefix/suffix/hide-empty all
  keep working; field access and the query are core's, unchanged.
- The colored value sits in a `.vcs-value` span with `min-width:40px` padding — expect slightly
  wider numeric cells once coloring is on.
