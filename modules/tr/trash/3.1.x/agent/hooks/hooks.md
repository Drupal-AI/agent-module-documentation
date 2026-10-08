<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

Defined in `trash.api.php`. Each receives the `EntityInterface` plus a `$langcodes` array (the
affected translations); the post-restore hooks receive `$deleted_timestamps` (deletion
timestamps keyed by langcode) instead. The generic and `ENTITY_TYPE`-specific variants fire
together.

| Hook | When |
|---|---|
| `hook_entity_pre_trash_delete($entity, array $langcodes)` | Before an entity/translation is soft-deleted. |
| `hook_ENTITY_TYPE_pre_trash_delete($entity, array $langcodes)` | Same, for one entity type. |
| `hook_entity_trash_delete($entity, array $langcodes)` | After an entity/translation has been soft-deleted. |
| `hook_ENTITY_TYPE_trash_delete($entity, array $langcodes)` | Same, for one entity type. |
| `hook_entity_pre_trash_restore($entity, array $langcodes)` | Before an entity is restored from trash. |
| `hook_ENTITY_TYPE_pre_trash_restore($entity, array $langcodes)` | Same, for one entity type. |
| `hook_entity_trash_restore($entity, array $deleted_timestamps)` | After an entity has been restored. |
| `hook_ENTITY_TYPE_trash_restore($entity, array $deleted_timestamps)` | Same, for one entity type. |
| `hook_trash_views_build(ViewExecutable $view, EntityTypeInterface $entity_type, bool $export)` | Alter the dynamically built Trash view for a type (see `TrashViewBuilder`). |

```php
function my_module_entity_trash_delete(\Drupal\Core\Entity\EntityInterface $entity, array $langcodes): void {
  \Drupal::logger('my_module')->notice('Trashed @id (@langs)', [
    '@id' => $entity->id(),
    '@langs' => implode(',', $langcodes),
  ]);
}
```

For richer per-type behaviour (restore validation, form alters) prefer a trash handler — see
[extend/trash-handler.md](../extend/trash-handler.md).
