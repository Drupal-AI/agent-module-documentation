<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trash manager service & static helpers

Service `trash.manager` (`Drupal\trash\TrashManagerInterface`, class `TrashManager`), also
autowirable by interface.

```php
/** @var \Drupal\trash\TrashManagerInterface $tm */
$tm = \Drupal::service('trash.manager');

$tm->isEntityTypeSupported($entityType);       // bool — SqlContentEntityStorage-based?
$tm->isEntityTypeEnabled('node', 'article');   // bool — type (+ optional bundle) enabled?
$tm->getEnabledEntityTypes();                  // ['node', 'taxonomy_term', ...]

// Enable/disable trash for an entity type (installs/uninstalls the 'deleted' field).
$tm->enableEntityType($entityType);            // EntityTypeInterface; throws on unsupported/dup
$tm->disableEntityType($entityType);
```

## Trash context

Controls whether entity/Views queries hide soft-deleted rows and whether a delete soft- or
hard-deletes. One of `active` (normal: intercept deletes, hide trashed), `inactive` (work
inside the bin: can load trashed rows, delete = permanent purge), `ignore` (do nothing: no
query alteration, load anything, delete = permanent).

```php
$tm->getTrashContext();                 // current context string
$tm->shouldAlterQueries();              // FALSE only when context is 'ignore'
$tm->setTrashContext('ignore');         // also invalidates entity memory cache tags

// Preferred: run a callback in a context, restoring the previous one afterwards.
$deleted = $tm->executeInTrashContext('ignore', fn() => $storage->load($id));
```

- To soft-delete: call the entity's normal `$entity->delete()` — trash intercepts it for
  enabled types via the generated storage subclass. To hard-delete, run the delete in the
  `inactive`/`ignore` context.
- After a delete or restore a **new default revision is created**; any in-memory reference to
  the entity is stale and must be reloaded before further operations.
- `getHandler($entity_type_id)` — the `TrashHandlerInterface` for a type (or NULL). See
  [extend/trash-handler.md](../extend/trash-handler.md).
- `getDeletedFieldDefinition()` — the `timestamp` base field (internal, translatable,
  revisionable, indexed) that marks an entity as trashed.

## Static helpers — `Drupal\trash\Trash` (final)

```php
use Drupal\trash\Trash;

Trash::entityIsDeleted($entity);                 // bool — this translation trashed?
Trash::entityHasDeletedTranslations($entity);    // bool — any translation trashed?
Trash::entityHasAllTranslationsDeleted($entity); // bool — every translation trashed?
Trash::restoreEntity($entity, $langcodes = []);  // restore (default translation always included)
```

`entityIsDeleted()` returns TRUE only when the `deleted` field is provided by `trash` and is
non-empty. `restoreEntity()` no-ops when the entity type is not trash-enabled, then delegates
to the storage's `restoreFromTrash()` (`TrashStorageInterface`).

> The procedural `trash_entity_is_deleted()` / `trash_restore_entity()` wrappers are
> deprecated (removed target trash:3.1.0) — use the `Trash::` static methods.

Restore/purge from code programmatically via the entity forms, the `entity:restore_action` /
`entity:purge_action` bulk actions, or the Drush commands — see
[plugins/operations.md](../plugins/operations.md) and [drush/commands.md](../drush/commands.md).
