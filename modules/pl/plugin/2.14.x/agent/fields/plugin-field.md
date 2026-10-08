# The `plugin` (plugin collection) field type

Lets an entity store a **chosen plugin id + its configuration** as a field value. The field type
is derived per plugin type, so its concrete ids are `plugin:<plugin_type_id>`.

## Field type

- Base id `plugin` — `Drupal\plugin\Plugin\Field\FieldType\PluginCollectionItem`.
- Deriver `PluginCollectionItemDeriver` creates one derivative per registered plugin type whose
  `isFieldType()` is TRUE → e.g. `plugin:block`, `plugin:condition`, `plugin:action`,
  `plugin:image_effect`, `plugin:queue_worker`, `plugin:views_style`, ... (the `field_type`
  plugin type itself opts out).
- Field type category: `plugin_reference` ("Plugin reference"), label "Plugin collection".
- `default_formatter = "plugin_label"`, list class `PluginCollectionItemList`.

### Stored columns / properties

Value shape (schema `field.value.plugin:*`): `plugin_id` (string), `plugin_configuration`
(typed by the plugin's own schema), `plugin_configuration_schema_id` (string).

## Widget

- Base id `plugin_selector` — `Drupal\plugin\Plugin\Field\FieldWidget\PluginSelector` (deriver
  `PluginSelectorDeriver`). It is **derived per selector**, so the concrete widget ids stored on
  a form display are `plugin_selector:plugin_radios` and `plugin_selector:plugin_select_list`.
  The widget wraps that Plugin selector so the edit form offers the plugin choice + its
  configuration for the field's plugin type.

## Formatters

| id | Class | Renders |
|---|---|---|
| `plugin_label` | `PluginLabel` | the selected plugin's human label. |
| `plugin_block_built` | `BuiltBlock` | builds and renders the selected **block** plugin (block field types only). |

## Add a plugin field (code)

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_my_condition',
  'entity_type' => 'node',
  'type' => 'plugin:condition',           // plugin:<plugin_type_id>
])->save();
FieldConfig::create([
  'field_name' => 'field_my_condition',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'A condition',
])->save();
```

Then set the `plugin_selector` widget and a `plugin_label` formatter on the form/view displays.

## Read back

`drush field:info node.article` or inspect
`field.storage.node.field_my_condition` — its `type` is `plugin:condition`.
