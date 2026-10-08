# Content Entity Clone — hooks

The module invites one hook (from `content_entity_clone.api.php`).

## `hook_content_entity_clone_field_processor_info_alter(array &$definitions)`

Alter the discovered field-processor plugin definitions — add, remove, or change processors without
creating an annotated plugin class. `$definitions` is keyed by processor id; each value is an array
with `id`, `label`, `description`, `fieldTypes`, `class`, `provider`.

```php
function mymodule_content_entity_clone_field_processor_info_alter(array &$definitions) {
  $definitions['uppercase'] = [
    'id' => 'uppercase',
    'label' => t('Uppercase'),
    'description' => t('Make the field values uppercase.'),
    'fieldTypes' => ['text', 'string'],
    'class' => 'Drupal\\mymodule\\Plugin\\content_entity_clone\\FieldProcessor\\Uppercase',
    'provider' => 'mymodule',
  ];
}
```

This corresponds to the manager's `alterInfo('content_entity_clone_field_processor_info')`.

## Related core hooks the module itself implements (for reference, not for you to implement)

- `hook_entity_prepare_form()` — copies configured field values onto the new (clone) entity when the
  request carries `?content_entity_clone=<id>`.
- `hook_entity_operation()` / `hook_menu_local_tasks_alter()` — add the **Clone** operation/local task.
- `hook_module_implements_alter()` — ensures its `entity_prepare_form` runs first.

To add cloning behavior you normally write a **FieldProcessor plugin** (see
[../plugins/field-processor.md](../plugins/field-processor.md)) rather than implementing these.
