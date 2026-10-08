# Dimension — field types, widgets, formatters

All three field types extend an abstract `Dimension` base (`FieldType/Dimension.php` extending
core `DecimalItem`); each variant mixes in a trait defining its components via `fields()`.

## Field types

| Field type id | Components (`fields()`) | Default widget | Default formatter |
|---|---|---|---|
| `length_field_type` | `length` | `length_field_widget` | `length_field_formatter` |
| `area_field_type` | `width`, `height` | `area_field_widget` | `area_field_formatter` |
| `volume_field_type` | `length`, `width`, `height` | `volume_field_widget` | `volume_field_formatter` |

Each stores one numeric DB column per component **plus** a computed `value` column.

## The calculation

`preSave()` rounds each component to its `<key>_scale` and sets
`value = calculate(components)`:

```
value = round( Π ( round(component, scale) × component.factor ) , value_scale )
```

So Area `value = width × width.factor × height × height.factor`; Volume multiplies all three;
Length is `length × length.factor`. `isEmpty()` is true if any component is empty (and not
the string "0"). Numeric input is enforced by a Regex constraint; `min`/`max` field settings
add Range constraints.

## Widgets

Widgets extend core `NumberWidget` (`FieldWidget/Dimension.php`). `formElement()` renders one
`number` input per component (with per-component `label`, `placeholder`, `description`,
`#step` from scale, `#min`/`#max`, prefix/suffix) plus a **disabled** `value` "Dimension"
input. The `dimension/widget` JS library (`js/dimension.js`) reads
`drupalSettings.dimension[<field-config-id>]` (each component's `scale` and `factor`) and
updates the total live as the editor types. Widget settings per component: `label`,
`placeholder`, `description`.

## Formatters

- **Value formatters** — `length_field_formatter`, `area_field_formatter`,
  `volume_field_formatter` (extend core `DecimalFormatter`): render the computed `value`,
  applying the `value` component's prefix/suffix (e.g. ` m²`).
- **Components formatters** — `area_components_field_formatter`,
  `volume_components_field_formatter` (extend `StringFormatter`): render the raw components via
  `#theme` = the plugin id. Templates:
  - `area-components-field-formatter.html.twig`: `{{ width }} x {{ height }}`
  - `volume-components-field-formatter.html.twig` (width/height/length variables).
  (There is no separate "length components" formatter — Length has a single component.)

## Create a field programmatically

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_dim_area', 'entity_type' => 'node', 'type' => 'area_field_type',
])->save();
FieldConfig::create([
  'field_name' => 'field_dim_area', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Area',
])->save();
```

Field/storage settings (factor, min, max, prefix, suffix, precision, scale) are documented in
[../configure/field-settings.md](../configure/field-settings.md).
