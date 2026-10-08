<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Color field, formatters and widget

Available only when `enable_color_field` is true (the default).

## Field type: `colorapi_color_field`

- Class `ColorItem` (`@FieldType id = colorapi_color_field`,
  `default_formatter = colorapi_color_display`, `default_widget = colorapi_color_widget`).
- **Storage columns:** `name` (varchar 255, nullable) and `color` (varchar 7, nullable — a
  `#RRGGBB` string).
- **Properties:** `name` (string), `color` (Typed Data `colorapi_color`, required), and a
  computed `value` (the hex without the leading `#`).
- `setValue()` accepts `color` as a `#hex` string (or `['hexadecimal' => '#hex']`) and, via
  `colorapi.service->hexToRgb()`, populates red/green/blue on the color property.
- `isEmpty()` is true when the hex value is null/empty/false.

Create a Color field in code:

```php
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_brand_color', 'entity_type' => 'node',
  'type' => 'colorapi_color_field',
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_brand_color', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Brand color',
])->save();
```

## Formatters

| Formatter id | Renders | Settings |
|---|---|---|
| `colorapi_color_display` (default) | a colored block/square (`colorapi-color-display` template) | `display_name` |
| `colorapi_text_display` | styled text (`colorapi-text-display` template) | `display_name`, `show_hash` |
| `colorapi_raw_hex_display` | the raw hex string | `display_name`, `show_hash` |
| `colorapi_raw_rgb_display` | the raw RGB values | `display_name` |

- `display_name` (bool) — also print the human-readable color name.
- `show_hash` (bool) — prefix hex output with `#`.

Set a formatter on a view display:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_brand_color', [
  'type' => 'colorapi_raw_hex_display',
  'settings' => ['display_name' => TRUE, 'show_hash' => TRUE],
])->save();
```

## Widget

- Default widget `colorapi_color_widget` (`ColorapiWidget`, base `ColorapiWidgetBase`).
- For an actual color-picker UI, install the `jquery_colorpicker` contrib module
  (see README). Without it you get plain text inputs for name + hex.

## Theming

`colorapi_theme()` defines `colorapi_color_display` and `colorapi_text_display` theme hooks
(templates `colorapi-color-display.html.twig`, `colorapi-text-display.html.twig`), each with
`delta`, `item`, and `hexadecimal_color` variables.
