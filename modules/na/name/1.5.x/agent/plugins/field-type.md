<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `name` field type, widget & formatter

Three core-plugin implementations (no new plugin *type* is defined):
- Field type `name` (`src/Plugin/Field/FieldType/NameItem.php`) — `default_widget: name_default`,
  `default_formatter: name_default`.
- Widget `name_default` "Name components" (`FieldWidget/NameWidget.php`).
- Formatter `name_default` "Name formatter" (`FieldFormatter/NameFormatter.php`).

## Storage & properties
Six string columns / properties: `title, given, middle, family, generational, credentials`
(all `varchar(255)`; indexes on `given` and `family`). `mainPropertyName()` is `NULL` (compound
field). `isEmpty()` ignores title/generational alone. Config schema keys live under
`field.field_settings.name`, `field.value.name`, `field.widget.settings.name_default`,
`field.formatter.settings.name_default` in `config/schema/name.schema.yml`.

## Per-field settings (`field.field_settings.name`)
- `components` — booleans per component; default **all six enabled**.
- `minimum_components` — which are required; default **given + family** required.
- `max_length` — per component (defaults: title 31, given 63, middle 127, family 63,
  generational 15, credentials 255).
- `labels` — override component labels (e.g. "Surname").
- `field_type` — `text` or `select` per component (title & generational default `select`).
- `title_options`, `generational_options` — the select lists (Mr./Mrs./Dr…; Jr./Sr./III…).
- `autocomplete_source`, `autocomplete_separator`, `autocomplete_match` — autocomplete config.
- `allow_family_or_given` — accept either family or given to satisfy the requirement.
- On a **User** name field only: `override_format` and the "override login name" checkbox
  (writes `name.settings.user_preferred`).

## Formatter settings (`field.formatter.settings.name_default`)
- `format` — the `name_format` entity id to render with (e.g. `default`, `family`, `full`).
- `list_format` — the `name_list_format` id for multi-value output.
- `markup` — one of `none/raw/simple/microdata/rdfa`.
- `link_target` — link the name to the entity/user.

## Add a name field in code
```php
use Drupal\field\Entity\{FieldStorageConfig, FieldConfig};
FieldStorageConfig::create([
  'field_name' => 'field_name_full', 'entity_type' => 'node', 'type' => 'name',
])->save();
FieldConfig::create([
  'field_name' => 'field_name_full', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Full name',
])->save();
// then set widget/formatter components on the form/view displays (type 'name_default').
```
Inspect a live field: `drush cget field.field.node.<bundle>.<field> settings.components`.
The formatter's chosen format: `drush cget core.entity_view_display.node.<bundle>.default content.<field>.settings.format`.
