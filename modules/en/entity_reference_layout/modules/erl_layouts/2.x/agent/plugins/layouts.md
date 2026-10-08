# Aten Layouts — layouts & options

## Layouts (`erl_layouts.layouts.yml`)
All use `class: \Drupal\erl_layouts\Plugin\Layout\ErlLayout`, template
`templates/layouts/columns`, library `erl_layouts/erl_layouts`.

| Layout id | Label | Regions |
|---|---|---|
| `layout_onecolumn` | One Column [1] | primary |
| `layout_twocolumn_halves` | Two Column [1:1] | header, primary, secondary, footer |
| `layout_twocolumn_onethird_twothirds` | Two Column [1:2] | header, primary, secondary, footer |
| `layout_twocolumn_twothirds_onethird` | Two Column [2:1] | header, primary, secondary, footer |
| `layout_threecolumn_thirds` | Three Column [1:1:1] | header, primary, secondary, tertiary, footer |
| `layout_threecolumn_half_quarter_quarter` | Three Column [2:1:1] | + tertiary |
| `layout_threecolumn_quarter_half_quarter` | Three Column [1:2:1] | + tertiary |
| `layout_threecolumn_quarter_quarter_half` | Three Column [1:1:2] | + tertiary |

## `ErlLayout` configuration
`defaultConfiguration()` provides `layout_classes`, `layout_bg_color`, and per-region
`classes` / `bg_color`. `build()` implodes classes onto `#attributes['class']` and sets
`#attributes['style'] = 'background-color: ' . $color` on the layout and each region wrapper.

## Input modes (set on the ERL widget's third-party settings form)
`erl_layouts_field_widget_third_party_settings_form` adds, for the `entity_reference_layout_widget`,
mode selectors for **layout classes, region classes, layout color, region color**. Each mode:

- `manual` — author types a free value (textfield). Classes are space-separated; color is a hex code.
- `select` — author picks from a site-builder list defined as one `key|label` per line
  (`getSelectOptions()` splits on `|`; the key is the actual class/color).
- `force` — a fixed value from the widget settings (`*_force`) is applied automatically; no author input.

Site builders pick the mode in *Manage form display → (gear on the ERL field) → third-party
settings*. Use `select`/`force` to constrain what authors can enter; `manual` allows arbitrary
class/CSS-color strings (rendered via Drupal `Attribute`, HTML-escaped — no attribute breakout,
but otherwise unconstrained CSS).
