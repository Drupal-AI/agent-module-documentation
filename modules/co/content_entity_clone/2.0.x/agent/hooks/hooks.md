# Content Entity Clone — hooks

The module invites one hook (from `content_entity_clone.api.php`).

## `hook_content_entity_clone_field_processor_info_alter(array &$definitions)`

Alter the discovered field-processor plugin definitions — add, remove, or change processors
without creating an attributed plugin class. `$definitions` is keyed by processor id; each value is
an array with `id`, `label`, `description`, `fieldTypes`, `class`, `provider`.

```php
function mymodule_content_entity_clone_field_processor_info_alter(array &$definitions) {
  $definitions['uppercase'] = [
    'fieldTypes' => ['text', 'string'],
    'id' => 'uppercase',
    'label' => t('Uppercase'),
    'description' => t('Make the field values uppercase.'),
    'class' => 'Drupal\\mymodule\\Plugin\\content_entity_clone\\FieldProcessor\\Uppercase',
    'provider' => 'mymodule',
  ];
}
```

Prefer defining a real plugin with the `#[ContentEntityCloneFieldProcessor]` attribute
(see [../plugins/field-processor.md](../plugins/field-processor.md)); use this hook only to tweak
existing definitions. Corresponds to the manager's `alterInfo('content_entity_clone_field_processor_info')`.

## Core hooks the module itself implements (for reference, not for you to implement)

In 2.x these live in a single OOP hook class,
`Drupal\content_entity_clone\Hook\ContentEntityCloneHooks`, each method tagged with the
`#[Hook('...')]` attribute (`content_entity_clone.hooks_converted: true`); there is no `.module`
file of procedural hooks.

- `#[Hook('entity_prepare_form', order: Order::First)]` — copies configured field values onto the
  new (clone) entity when the request carries `?content_entity_clone=<id>`. Runs first so other
  modules' `entity_prepare_form` see the pre-filled values. Gated on the `clone content entities`
  permission and **update** access to the source entity.
- `#[Hook('entity_operation')]` / `#[Hook('menu_local_tasks_alter')]` — add the **Clone**
  operation / local task, both delegating to the `CloneLinkGenerator` service (which enforces the
  permission, bundle-enabled config, target creation-route access, and source update access).
- `#[Hook('help')]` — help text on `help.page.content_entity_clone`.

To add cloning behavior you normally write a **FieldProcessor plugin** rather than implementing
any of these.
