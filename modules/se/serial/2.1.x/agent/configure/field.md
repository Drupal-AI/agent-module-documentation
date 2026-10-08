# Adding & configuring a Serial field

There is no settings page. You configure Serial by **adding a field of type `serial`** to a
bundle, then setting its storage settings.

## Via Field UI

1. Go to the bundle's *Manage fields* (e.g. `/admin/structure/types/manage/article/fields`).
2. Add field → choose **Serial** (category "Number").
3. On the storage-settings step set:
   - **Starting value** (`start_value`, default 1) — the first serial number.
   - **Start on existing entities** (`init_existing_entities`, No/Yes) — if Yes and the
     bundle already has entities, they are back-filled with serial values starting from
     `start_value`.
   Both are **disabled once the field has data** (`$has_data`).
4. Save. The widget is **"Hidden (Automatic)"** — editors never enter the value.

## The config it writes

`start_value` / `init_existing_entities` are **storage** settings (schema
`field.storage_settings.serial`):

```bash
drush config:get field.storage.node.field_invoice_no settings
# settings:
#   start_value: 1000
#   init_existing_entities: 0
```

## Create a serial field programmatically

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_invoice_no',
  'entity_type' => 'node',
  'type' => 'serial',
  'settings' => ['start_value' => 1000, 'init_existing_entities' => 0],
])->save();
FieldConfig::create([
  'field_name' => 'field_invoice_no',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Invoice number',
])->save();
```

Creating the `FieldConfig` triggers `serial_field_config_create()`, which auto-creates the
assistant table. Deleting it drops the table.

## Widget & formatter

- Widget `serial_default_widget` — a hidden form element (value auto-assigned on save; you
  normally don't change this).
- Formatter `serial_default_formatter` — renders the integer via the `serial_default` theme
  hook. Make the field visible on the entity's *Manage display* to show the number.

## Notes

- Values are assigned **only to new entities** (and new translations). Cloning a node resets
  its serial fields (`serial_clone_node_alter`).
- The counter is **per entity-type + bundle + field**; separate fields/bundles have separate
  sequences.
