# Use the `entity_browser` element in code

`Drupal\entity_browser\Element\EntityBrowserElement` (`#type => 'entity_browser'`) is a
form element that renders a configured browser inline and returns selected entities.
This is how the field widgets and the IEF submodule embed a browser.

```php
$form['picker'] = [
  '#type' => 'entity_browser',
  '#entity_browser' => 'sample',        // browser config entity id (required)
  '#cardinality' => 3,                  // max selectable; -1 = unlimited
  '#default_value' => $entities,        // array of entity objects
  '#selection_mode' => 'selection_append',
  '#widget_context' => [                // passed to widgets (e.g. View)
    'target_bundles' => ['article'],
    'target_entity_type' => 'node',
  ],
  '#entity_browser_validators' => [     // WidgetValidation plugins
    'entity_type' => ['type' => 'node'],
    'cardinality' => ['cardinality' => 3],
  ],
];
```

- Submitted value is a `type:id` string; convert with
  `EntityBrowserElement::processEntityIds($value)` → array of entities
  (or `processEntityId()` for one).
- Browser instances are loaded from the `entity_browser` storage:
  `\Drupal::entityTypeManager()->getStorage('entity_browser')->load($id)`.
- The `selectEntities()` method on `WidgetBase` and the `EntityBrowserEvents`
  dispatched during selection let widgets and subscribers react to picks.
- Plugin managers are injectable services, e.g. `plugin.manager.entity_browser.widget`.
