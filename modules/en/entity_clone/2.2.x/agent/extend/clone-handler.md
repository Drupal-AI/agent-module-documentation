# Custom clone handler for an entity type

Cloning behavior is an **entity handler**, not a plugin. `entity_clone_entity_type_build()`
assigns each entity type an `entity_clone` handler (and an `entity_clone_form` handler):

- Content entities default to `ContentEntityCloneBase` / `ContentEntityCloneFormBase`.
- Config entities default to `ConfigEntityCloneBase` / `ConfigEntityCloneFormBase`.
- Overridden per type in a `$specific_handler` map: `file` → `FileEntityClone`,
  `user` → `UserEntityClone`, `taxonomy_term` → `TaxonomyTermEntityClone`,
  `menu` → `MenuEntityClone` (+ `MenuEntityCloneForm`), `field_config` → `FieldConfigEntityClone`,
  `node_type`/`comment_type`/`block_content_type`/`contact_form`/`taxonomy_vocabulary` →
  `ConfigWithFieldEntityClone`, `entity_view_display` → `LayoutBuilderEntityClone` (when
  layout_builder is on).

## Provide your own
Implement `Drupal\entity_clone\EntityClone\EntityCloneInterface` (or subclass
`ContentEntityCloneBase` / `ConfigEntityCloneBase`) — the key method is
`cloneEntity($entity, $cloned_entity, $properties)` which returns the saved copy. For a custom
clone form, implement `EntityCloneFormInterface`.

Register it from your own `hook_entity_type_build()` (or `hook_entity_type_alter()`), running
after entity_clone so yours wins:
```php
function my_module_entity_type_alter(array &$entity_types): void {
  $entity_types['my_entity']->setHandlerClass('entity_clone', \Drupal\my_module\MyEntityClone::class);
}
```
The clone-form route/link template (`/entity_clone/{entity_type}/{id}`) is provided for you.
