# api — create & inspect computed fields in code

## Services

| Service | Class | Use |
|---|---|---|
| `plugin.manager.computed_field` | `ComputedFieldManager` | Discover/instantiate computed field plugins. |
| `computed_field.computed_field_builder` | `ComputedFieldBuilder` | Builds field definitions (internal). |
| `computed_field.computed_field_class_factory` | `ComputedFieldClassFactory` | Maps field type → field item class (internal). |

Manager methods beyond the default plugin manager:

```php
$m = \Drupal::service('plugin.manager.computed_field');
$m->getDefinitions();                 // all plugins
$m->getUiDefinitions();               // only those without no_ui (shown in the add form)
$m->getAutomaticPlugins($entity_type);// instances of plugins that auto-attach to a type
```

## Create a configured computed field

A configured field is a `computed_field` config entity. Create it with the entity storage —
id is `{entity_type}.{bundle}.{field_name}`:

```php
\Drupal::entityTypeManager()->getStorage('computed_field')->create([
  'field_name'    => 'computed_backlinks',
  'entity_type'   => 'node',
  'bundle'        => 'article',
  'label'         => 'Backlinks',
  'plugin_id'     => 'reverse_entity_reference',
  'plugin_config' => ['reference_field' => 'node-uid'],
])->save();
```

Saving notifies `field_definition.listener` so the field enters the field map; the field then
shows on the bundle's entity view display (configure it under Manage Display). No
`FieldStorageConfig`/`FieldConfig` is created — the `computed_field` entity **is** the field,
and it is read-only (`isComputed()`/`isReadOnly()` return TRUE).

## Inspect / read back

```php
$cf = \Drupal::entityTypeManager()->getStorage('computed_field')
  ->load('node.article.computed_backlinks');
$cf->getType();                       // core field type from the plugin, e.g. 'entity_reference'
$cf->get('plugin_id');                // 'reverse_entity_reference'
$cf->get('plugin_config');            // ['reference_field' => 'node-uid']
$cf->getFieldValuePlugin();           // the plugin instance
```

The computed value on a loaded host entity is read like any field:
`$node->get('computed_backlinks')->referencedEntities()` (or `->value` for scalar types).

## Hook

`hook_computed_field_info_alter(array &$info)` — alter plugin definitions, e.g. swap a
plugin's `class`. Defined in `computed_field.api.php`.
