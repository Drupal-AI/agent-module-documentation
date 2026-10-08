<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `meaofd.fixer` service (`Drupal\meaofd\Services\Fixer`)

Stateless wrapper over core's `@entity.definition_update_manager` and `@entity_type.manager`.
Get it with `\Drupal::service('meaofd.fixer')` or inject `meaofd.fixer`.

## Methods

- `getChangeSummary(): array` — passthrough to `EntityDefinitionUpdateManager::getChangeSummary()`;
  associative array keyed by entity type id, each value an array of human-readable change strings.
  This is exactly what the Status report / report page reads.
- `entityTypeHasChanges(string $entity_type_id): bool` — TRUE if that id appears in the change summary.
- `fix(string $target_entity_type_id, bool $rebuild_entity_cache_definitions = TRUE, bool $log_events = TRUE): array`
  — if the entity type has changes, loads its definition and calls
  `EntityDefinitionUpdateManager::installEntityType()`, returning an array of the ids installed/updated
  (empty if nothing to do). Rebuilds cached entity-type definitions before and after when
  `$rebuild_entity_cache_definitions` is TRUE. Logs to the `meaofd` channel when `$log_events` is TRUE.
  Re-throws any `\Throwable` after logging it.

## Typical use — in a `hook_update_N()`

```php
function mymodule_update_10001() {
  // Reconcile the stored definitions of the node entity type with code.
  \Drupal::service('meaofd.fixer')->fix('node');
}
```

## Guarded call

```php
$fixer = \Drupal::service('meaofd.fixer');
if ($fixer->entityTypeHasChanges('paragraph')) {
  $updated = $fixer->fix('paragraph');   // e.g. ['paragraph']
}
```

Note: `fix()` uses `installEntityType()` (add missing/changed definitions); it does not itself run the
full entity update workflow for destructive field data migrations. It targets exactly the
"mismatched definitions" case surfaced on the Status report.
