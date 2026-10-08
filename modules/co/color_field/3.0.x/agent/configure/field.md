# Configure the Color field

No dedicated admin page — use **Field UI** (Manage fields / Manage form display /
Manage display). Field type id: **`color_field_type`** (label "Color").
Config schema in `config/schema/color_field.schema.yml`.

## Storage & field settings
- **Storage** `format`: how the hex is stored — `#HEXHEX`, `HEXHEX`, `#hexhex`,
  `hexhex` (case + optional leading `#`).
- **Field** `opacity` (bool): record an opacity value (0–1) with each color.
- Stored value columns: `color` (string hex), `opacity` (float). Validated by a
  hex regex and, when opacity is on, a 0–1 range constraint.

## Widgets (Manage form display)
| Widget id | Description | Key settings |
|---|---|---|
| `color_field_widget_default` | Plain text input | placeholder_color, placeholder_opacity |
| `color_field_widget_html5` | Native `<input type="color">` | show_extra |
| `color_field_widget_spectrum` | Spectrum.js picker (bundled lib) | show_input/palette/buttons, palette, allow_empty |
| `color_field_widget_box` | Preset color boxes (bundled lib) | default_colors |
| `color_field_widget_grid` | Grid swatch picker (bundled lib) | cell/box width+height, margin, columns |

Spectrum/box/grid widgets load remote JS libraries declared in
`color_field.libraries.yml` (some expect files under `/libraries/…`).

## Formatters (Manage display)
| Formatter id | Output | Key settings |
|---|---|---|
| `color_field_formatter_text` | Hex/RGB text | format, opacity |
| `color_field_formatter_swatch` | Colored swatch | shape, width, height, opacity, data_attribute |
| `color_field_formatter_swatch_options` | Swatch (options variant) | inherits swatch settings |
| `color_field_formatter_css` | Injects a CSS declaration | selector, property, important, opacity, advanced, css |

The CSS formatter can set e.g. `background-color` on a chosen selector so a
field value styles the page. Default widget/formatter are the text ones.
