# Hooks

Defined in `trash.api.php`. All receive the `EntityInterface` being trashed/restored.

| Hook | When |
|---|---|
| `hook_entity_pre_trash_delete($entity)` | Before an entity is soft-deleted. |
| `hook_ENTITY_TYPE_pre_trash_delete($entity)` | Same, for one entity type. |
| `hook_entity_trash_delete($entity)` | After an entity has been soft-deleted. |
| `hook_ENTITY_TYPE_trash_delete($entity)` | Same, for one entity type. |
| `hook_entity_pre_trash_restore($entity)` | Before an entity is restored from trash. |
| `hook_ENTITY_TYPE_pre_trash_restore($entity)` | Same, for one entity type. |
| `hook_entity_trash_restore($entity)` | After an entity has been restored. |
| `hook_ENTITY_TYPE_trash_restore($entity)` | Same, for one entity type. |
| `hook_trash_views_build(ViewExecutable $view, EntityTypeInterface $entity_type, bool $export)` | Alter the dynamically built Trash view for a type. |

```php
function my_module_entity_trash_delete(\Drupal\Core\Entity\EntityInterface $entity): void {
  \Drupal::logger('my_module')->notice('Trashed @id', ['@id' => $entity->id()]);
}
```

For richer per-type behavior (restore validation, form alters) prefer a trash handler —
see [extend/trash-handler.md](../extend/trash-handler.md).
