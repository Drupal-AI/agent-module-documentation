# Trash manager service

Service `trash.manager` (`Drupal\trash\TrashManagerInterface`), also autowirable by interface.

```php
/** @var \Drupal\trash\TrashManagerInterface $tm */
$tm = \Drupal::service('trash.manager');

// Is a type enabled for trashing?
$tm->isEntityTypeEnabled('node', 'article');   // bool
$tm->getEnabledEntityTypes();                  // ['node', 'taxonomy_term', ...]

// Enable/disable trash for an entity type (updates config + rebuilds).
$tm->enableEntityType($entityType);            // EntityTypeInterface
$tm->disableEntityType($entityType);
```

**Trash context** controls whether entity/Views queries hide soft-deleted rows:

```php
// Context is one of 'active' (hide trashed), 'inactive' (normal), 'ignore' (bypass filter).
$tm->getTrashContext();                 // current context string
$tm->setTrashContext('ignore');

// Run a callback in a context, e.g. to load a soft-deleted entity:
$deleted = $tm->executeInTrashContext('ignore', fn() => $storage->load($id));
```

- To soft-delete: just call the entity's normal `$entity->delete()` — trash intercepts it
  for enabled types. To bypass trash and hard-delete, wrap the call in
  `executeInTrashContext('inactive', ...)`.
- `shouldAlterQueries()` — whether trash is currently filtering queries.
- `getHandler($entity_type_id)` — the `TrashHandlerInterface` for a type (or NULL). See
  [extend/trash-handler.md](../extend/trash-handler.md).
- Restore/purge programmatically via the entity forms/actions
  (`RestoreAction`, `PurgeAction`) or the Drush commands.
