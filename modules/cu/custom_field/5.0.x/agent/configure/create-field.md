<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & configure a Custom Field

There is **no admin settings page** (`configure: null`). A Custom Field is created like any
field, but its **storage settings carry a `columns` array** that defines the subfields.

## Storage: the `columns` setting

`field.storage.<entity>.<field>` → `settings.columns` is keyed by column machine name. Each
column needs at least `name` and `type` (a `custom_field_type` plugin id). Some types take
extra keys (e.g. `string` → `max_length`, `unsigned`, `datetime` → `datetime_type`).

```yaml
# field.storage.node.field_spec
type: custom
settings:
  columns:
    headline:
      name: headline
      type: string
      max_length: 255
    rank:
      name: rank
      type: integer
```

The field's table gets one DB column per subfield named `<field>_<column>` (e.g.
`field_spec_headline`, `field_spec_rank`). At least one column must exist (default is a single
`value` string column) or the table cannot be created.

## Create it scriptably (drush php:eval)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_spec', 'entity_type' => 'node', 'type' => 'custom',
  'cardinality' => 1,
  'settings' => ['columns' => [
    'headline' => ['name' => 'headline', 'type' => 'string', 'max_length' => 255],
    'rank'     => ['name' => 'rank', 'type' => 'integer'],
  ]],
])->save();
FieldConfig::create([
  'field_name' => 'field_spec', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Spec',
])->save();
```

Read it back: `drush cget field.storage.node.field_spec settings.columns`.

## Widgets — the parent form widget

The parent field is edited with one of two base widgets on `core.entity_form_display.*`:

- `custom_flex` — columns laid out in a configurable CSS-flexbox grid (visual settings JS).
- `custom_stacked` — columns stacked one per row.

Per-column input is chosen with a `custom_field_widget` plugin, stored under the widget
component's `settings.fields.<column>.type` (widget id) plus that widget's own settings
(the base widget also has `settings.wrapper`, `label_value`, `open`, etc.). Widget ids include
`text textarea select radios checkbox integer decimal float
email url telephone color color_boxes datetime_default datetime_datelist datetime_local
daterange_default time_widget time_range duration link_default entity_reference_autocomplete
entity_reference_select entity_reference_radios file_generic image_image hierarchical_select
map_key_value map_text uuid hidden`.

```php
$fd = \Drupal::service('entity_type.manager')->getStorage('entity_form_display')
  ->load('node.article.default');
$fd->setComponent('field_spec', [
  'type' => 'custom_flex', 'weight' => 5, 'region' => 'content',
  'settings' => ['fields' => [
    'headline' => ['type' => 'text'],
    'rank'     => ['type' => 'integer'],
  ]],
])->save();
```

## Formatters — how the field displays

Set a base formatter on `core.entity_view_display.*`:
`custom_formatter` (themed via `custom-field.html.twig`), `custom_inline`, `custom_list`,
`custom_table`, `flipped_table`, `custom_template` (Twig rewrite like a Views field), or
`custom_field_sdc` (render through a Single Directory Component). Each column then picks a
`custom_field_formatter` plugin (ids include `string text_default number_integer
number_decimal boolean datetime_default datetime_custom image link map_table entity_reference_label` …).

## Clone / add / remove columns on populated fields

You can clone a field's column config from any entity type in the UI, and add or drop a
column on a field that already has data with the Drush commands
([drush/updater.md](../drush/updater.md)) or the `custom_field.update_manager` service
([api/services.md](../api/services.md)).
