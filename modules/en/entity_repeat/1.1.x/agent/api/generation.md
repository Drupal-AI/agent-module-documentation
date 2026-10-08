<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Occurrence generation flow

The clone-per-occurrence logic lives in the event subscriber plus procedural helpers in
`entity_repeat.module`. It is triggered by saving an entity whose Date Recur field was submitted with
the widget's "enable repeat" checkbox on (see [../fields/widget.md](../fields/widget.md)).

## Trigger — EntityRepeatEventSubscriber::onSave

`src/EventSubscriber/EntityRepeatEventSubscriber.php` subscribes to
`Drupal\date_recur\Event\DateRecurEvents::FIELD_VALUE_SAVE` (dispatched by
`DateRecurFieldItemList::postSave` after an entity with a date_recur field is saved). `onSave()`:
- gets the field/entity; returns immediately unless `$entity->data['entity_repeat_enabled']` is set
  (the flag the widget's `validateModularWidget()` writes). So a plain API save, or a save by a user
  without repeat access, never generates anything.
- `unset($entity->data['entity_repeat_enabled'])` to avoid an infinite regeneration loop.
- `$dates = $field->get(0)->getHelper()->getOccurrences()`; `array_shift($dates)` drops the first
  occurrence (that is the original entity itself, so it is not duplicated).
- calls `_entity_repeat_generate_entities($entity, $helper, $dates)`.

## _entity_repeat_generate_entities()

- resets the replication log: key/value `replications:{uuid}` set to `[]` (UUID because the entity id
  may not yet exist on add).
- invokes `hook_entity_repeat_generate_alter($entity, $helper, $dates)` (alterable, see below).
- logs `"Repeating the @type %title @count times."` to the `entity_repeat` channel.
- builds one batch operation per date (`_entity_repeat_batch_create_entity`) and calls `batch_set()`
  with `finished => _entity_repeat_batch_finished`.

## _entity_repeat_batch_create_entity() → _entity_repeat_create_entity()

Each batch op extracts `getStart()`/`getEnd()` timestamps from the `DateRange` and calls
`_entity_repeat_create_entity($entity, $start, $end)`, which:
- `\Drupal::service('replicate.replicator')->cloneEntity($entity)` — full clone via the Replicate
  module.
- finds the entity's date_recur field (`_entity_repeat_get_recur_field()` iterates field definitions
  for the first `date_recur` type), copies delta-0 values, overwrites `value`/`end_value` with the
  occurrence dates (format `Y-m-d\TH:i:s`) and sets `rrule = ''` so the clone does not recur.
- `\Drupal::moduleHandler()->alter('entity_repeat_create_entity', $clone, $recur_field, $context)`
  where `$context` is `['start_date' => …, 'end_date' => …]`.
- `$clone->save()`, then appends the clone UUID to key/value `replications:{uuid}`.

`_entity_repeat_batch_finished()` shows a "%count %items have been generated." message (or an error).

## Key/value tracking

`_entity_repeat_get_kv($entity)` returns `\Drupal::keyValue("config.entity.key_store.entity_repeat.{entity_type}")`.
The list under `replications:{original-uuid}` holds the UUIDs of every generated clone — consumed by
the `entity_repeat_group` submodule to add clones to a group.

## Hooks (entity_repeat.api.php)

- `hook_entity_repeat_generate_alter($entity, $helper, array $dates)` — inspect/alter the occurrence
  set before batching.
- `hook_entity_repeat_create_entity_alter($clone, $recur_field, array $context)` — alter each clone
  (with its start/end dates) before it is saved.
