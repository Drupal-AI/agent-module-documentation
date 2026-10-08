<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ereftras.synchronize service

```php
/** @var \Drupal\ereftras\SynchronizeService $svc */
$svc = \Drupal::service('ereftras.synchronize');
$svc->synchronize($entity_type, $bundle, $field_names, $only_empty);
```

Parameters:
- `$entity_type` (string) — content entity type id (must have a `langcode` key).
- `$bundle` (string) — bundle machine name; entities are loaded with `loadByProperties(['type' => $bundle])`.
- `$field_names` (array) — translatable `entity_reference` field machine names to copy.
- `$only_empty` (bool) — when TRUE (default) only fills empty translated values; FALSE overwrites all.

Behaviour: iterates every entity of the bundle and every translation, copies the original field value into the translation when the condition matches, and queues a Batch API operation that calls `$entity->save()` per changed translation (`SynchronizeService::saveEntities`).

Note (from the UI form): the `non_empty` checkbox is inverted before it reaches the service — `$only_empty = !$form_state->getValue('non_empty')`.

Access caveat: the bundled admin form is exposed via `_access: 'TRUE'`. If you build your own trigger, gate it behind an appropriate permission; do not rely on the module's route protection.
