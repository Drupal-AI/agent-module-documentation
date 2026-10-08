<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Save-time enforcement

Method: `ExclusiveBooleanHooks::entityPresave()` (src/Hook/ExclusiveBooleanHooks.php), wired via
`#[Hook('entity_presave')]` and the `#[LegacyHook]` wrapper `exclusive_boolean_entity_presave()` in
`exclusive_boolean.module`, which calls `\Drupal::service('exclusive_boolean.hooks')`.

## Algorithm

For **every** entity being saved:

1. Return immediately unless `$entity instanceof NodeInterface` (non-node entities are never processed).
2. `$node_type = $entity->bundle()`; iterate `$entity->getFieldDefinitions()`.
3. Skip any field whose `getType() !== 'boolean'`.
4. Load `FieldConfig::loadByName('node', $node_type, $field_name)`; skip if none, or if its third-party
   setting `exclusive_boolean.exclusive` is falsey.
5. Read `$entity->get($field_name)->value`. Only act when it is truthy (`== TRUE`).
6. When acting, run an entity query on `node` storage:

```php
$query = $node_storage->getQuery()
  ->condition('type', $node_type)
  ->condition($field_name, TRUE)
  ->accessCheck(FALSE);
if (!$entity->isNew()) {
  $query->condition('nid', $entity->id(), '<>');   // exclude the node being saved
}
$nids = $query->execute();
```

7. `loadMultiple($nids)`, then for each other node `$node->set($field_name, FALSE); $node->save();`.

Result: after the save completes, only the just-saved node has the field TRUE among that bundle.

## Notes for operators / integrators

- The query is a **Drupal entity query** with bound conditions (`type`, the boolean field, `nid <>`); values
  are parameterised by the query builder — no string-concatenated SQL.
- Enforcement fires on **any** save path that goes through `hook_entity_presave` (UI, migrations,
  programmatic `->save()`, other modules), not just the node form.
- Each affected other node is **fully re-saved** inside presave. On bundles with revisioning this creates a
  new default revision, updates the `changed` timestamp, and runs those nodes' own update hooks — so setting
  the flag on one node has a write cost proportional to how many other nodes currently hold it (normally 0
  or 1).
- The flag is read as a single `->value`; the module targets the standard single-cardinality boolean widget.

## Services & hook wiring

- `exclusive_boolean.services.yml` defines `exclusive_boolean.hooks`
  (`Drupal\exclusive_boolean\Hook\ExclusiveBooleanHooks`, `autowire: true`); constructor injects
  `EntityTypeManagerInterface`.
- `exclusive_boolean.module` contains only `#[LegacyHook]` shims plus helper wrappers
  (`exclusive_boolean_add_widget_description`, `..._add_exclusive_option`,
  `..._field_config_entity_builder`) that delegate to the service. No other PHP files exist.
