# Generate aliases in code

Service `pathauto.generator` (`Drupal\pathauto\PathautoGeneratorInterface`).

```php
/** @var \Drupal\pathauto\PathautoGeneratorInterface $g */
$g = \Drupal::service('pathauto.generator');

// Create/update the alias for an entity using the matching pattern.
$g->createEntityAlias($node, 'insert');            // $op: 'insert', 'update', 'bulkupdate'
$g->updateEntityAlias($node, 'update', ['force' => TRUE]);

// Inspect which pattern would apply to an entity.
$pattern = $g->getPatternByEntity($node);          // PathautoPatternInterface|NULL
```

- `createEntityAlias($entity, $op)` — returns the saved alias array, or NULL if no pattern
  matches / the entity opted out (a `path` field with `pathauto = 0`).
- `updateEntityAlias($entity, $op, $options)` — honors the global `update_action` setting;
  pass `['force' => TRUE]` to regenerate regardless.
- Normally you don't call this manually: pathauto's entity hooks
  (`PathautoEntityHooks`) fire on insert/update automatically once a pattern exists.
- Related services: `pathauto.alias_cleaner` (clean a string like pathauto would),
  `pathauto.alias_uniquifier` (add `-0`/`-1` suffix to avoid collisions),
  `pathauto.alias_storage_helper` (load/save/delete alias rows).
