# Programmatic API — the `replicate.replicator` service

Replicate has no UI. Everything goes through one service:
`replicate.replicator` (`Drupal\replicate\Replicator`).

```php
/** @var \Drupal\replicate\Replicator $replicator */
$replicator = \Drupal::service('replicate.replicator');
```

Or inject it: `arguments: ['@replicate.replicator']`.

## Four entry points

```php
// Clone WITHOUT saving — returns an unsaved duplicate (EntityInterface|NULL):
$clone = $replicator->cloneEntity($entity);
$clone = $replicator->cloneByEntityId('node', 1);   // loads, then clones

// Clone AND save — returns the saved duplicate (EntityInterface|NULL):
$clone = $replicator->replicateEntity($entity);
$clone = $replicator->replicateByEntityId('node', 1);
```

Use a `clone*` method when you want to alter the replica in your own code and save it
yourself; use a `replicate*` method to clone + save in one call.

## What a clone does (order of operations)

`cloneEntity()`:
1. `$clone = $entity->createDuplicate();` — core's shallow duplicate (new/unset IDs).
2. Dispatches `replicate__entity__{entity_type_id}` — a `ReplicateEntityEvent` carrying the
   **original** entity (`$event->getEntity()`), before any field-level work.
3. If the clone is fieldable, dispatches `replicate__entity_field__{field_type}` **once per
   field** — a `ReplicateEntityFieldEvent` (`getFieldItemList()` = that field on the clone,
   `getEntity()` = the clone).
4. Dispatches `replicate__alter` — a `ReplicateAlterEvent` with `getEntity()` (the clone) and
   `getOriginal()` (the source).

`replicateEntity()` additionally saves the clone, then dispatches `replicate__after_save`
(an `AfterSaveEvent`, `getEntity()` = the saved clone).

Event names are built by `ReplicatorEvents::replicateEntityEvent($type)`,
`ReplicatorEvents::replicateEntityField($fieldType)`, and the constants
`ReplicatorEvents::REPLICATE_ALTER` / `::AFTER_SAVE`. See
[extend/replicate.md](../extend/replicate.md) to subscribe to them.

## Deep vs shallow

`createDuplicate()` is **shallow**: entity-reference fields keep pointing at the same target
entities (targets are shared, not copied). To get a **deep** clone of a referenced entity,
subscribe to that reference field's `replicate__entity_field__{field_type}` event and
replace each item's target with a fresh clone — call `replicate.replicator` again on the
target (recursion). The bundled Layout Builder subscriber does exactly this for inline
blocks.

## Public field helpers

For partial/manual field cloning, two methods are public API:
- `cloneEntityField(FieldItemListInterface $source, FieldItemListInterface $target)` — copies
  values then post-processes.
- `postCloneEntityField(FieldItemListInterface $target_field)` — validates the target field
  (throws `FieldException` on violations or a non-fieldable parent) and fires that field's
  `replicate__entity_field__{field_type}` event.

## Built-in behaviour

- Drupal core entities (nodes, taxonomy vocabularies/terms, comments, files) clone out of
  the box.
- A `path` field subscriber clears `alias`/`pid` so a clone doesn't inherit the original's
  URL alias.
- A Layout Builder subscriber (registered only when `layout_builder` is enabled — see
  `ReplicateServiceProvider`) deep-clones inline block content in a duplicated layout.

## How other modules build on it

Higher-level clone tools use this event-driven pattern to give editors a UI while delegating
per-field/per-entity duplication rules to subscribers — e.g. **Quick Node Clone** and
**Entity Clone**. Reuse Replicate when you need code-level control rather than a UI.
