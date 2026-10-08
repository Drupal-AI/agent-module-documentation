<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How purging works

All logic lives in `entity_reference_purger.module` plus one QueueWorker. There are no
services to inject; the flow is driven by core hooks.

## On delete: `hook_entity_delete()`

`entity_reference_purger_entity_delete($entity)` runs whenever **any** entity is deleted:

1. Gets the field map of all `entity_reference` fields
   (`entity_field.manager->getFieldMapByFieldType('entity_reference')`).
2. For each `entity_type`/`bundle`/`field_name`, loads the field definition and **skips** it if
   it is computed or if `remove_orphaned` is not enabled
   (`entity_reference_purger_is_remove_orphaned_enabled()`).
3. Only proceeds if the field's `target_type` equals the **deleted entity's** entity-type id.
4. Loads parent entities that reference the deleted id
   (`getStorage($entity_type)->loadByProperties([$field_name => $entity->id()])`).
5. For each matching field item (`$field_item->target_id == $entity->id()`):
   - **`use_queue` FALSE** → `removeItem($delta)` on the parent, then, if the parent implements
     `RevisionLogInterface`, sets a new revision + revision user/time + a log message
     ("Removed orphaned entity reference via Entity Reference Purger module…"), then `save()`.
   - **`use_queue` TRUE** → `entity_reference_purger_add_to_queue()` pushes an item onto the
     `entity_reference_purger` queue with `{entity_type, entity_id, field_name, delta, target_id}`.

## Helper functions

- `entity_reference_purger_is_remove_orphaned_enabled($field_definition): bool` — reads
  `remove_orphaned` from `getThirdPartySettings()` (FieldConfig) or
  `getSetting('entity_reference_purger')` (BaseFieldDefinition).
- `entity_reference_purger_use_queue($field_definition): bool` — same, for `use_queue`.
- `entity_reference_purger_add_to_queue($parent_entity, $field_name, $delta, $target_id)`.

## Queue worker

`@QueueWorker(id = "entity_reference_purger", cron = {"time" = 60})` — class
`Plugin\QueueWorker\EntityReferencePurgerWorker`. On cron it re-loads the parent entity and
removes **all** deltas whose `target_id` matches the queued `target_id` (delta-only jobs from
older versions are handled as a fallback), reversing the delta order so indexes stay valid,
then creates a revision (if `RevisionLogInterface`) and saves. Run it with `drush queue:run
entity_reference_purger` or wait for cron. If `use_queue` is on, purges are **not** applied
until the queue is processed.
