<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How CER synchronises references

## Entry points (`cer.module`)

```php
hook_entity_insert($entity)  -> cer_sync_corresponding_references($entity);
hook_entity_update($entity)  -> cer_sync_corresponding_references($entity);
hook_entity_delete($entity)  -> cer_sync_corresponding_references($entity, TRUE);
```

`cer_sync_corresponding_references()` returns immediately for non-`FieldableEntityInterface`
entities, then loads **all enabled presets** with
`CorrespondingReferenceStorage::loadValid()` and calls
`$preset->synchronizeCorrespondingFields($entity, $deleted)` on each.

Because these are `insert`/`update`/`delete` hooks (not `presave`), CER **saves the other
entity separately** — the corresponding entity gets its own `save()`, its own hooks, and its
own revision if the entity type is revisionable.

## `synchronizeCorrespondingFields()`

1. `isValid($entity)` gate — entity type in `bundles`, bundle listed (or `*`), and the entity
   has at least one corresponding field. Otherwise return.
2. For each corresponding field the entity actually has:
   - `calculateDifferences($entity, $fieldName, $deleted)`
   - `$correspondingField = getCorrespondingField($fieldName)` — the *other* field, or the
     same field when the preset only names one distinct field.
   - `\Drupal::moduleHandler()->alter('cer_differences', $entity, $differences, $correspondingField)`
   - for each `add` / `remove` entity: `synchronizeCorrespondingField(...)`.

## `calculateDifferences()`

| Situation | Result |
|---|---|
| `$deleted` is TRUE | every currently referenced entity goes in **remove** |
| `$entity->original` is empty (insert) | every referenced entity goes in **add** |
| otherwise (update) | items present now but not in `original` → **add**; items in `original` but not now → **remove** |

Returned as `['add' => [...entities...], 'remove' => [...entities...]]`
(`CorrespondingReferenceOperations::ADD` = `'add'`, `::REMOVE` = `'remove'`).

## `synchronizeCorrespondingField()`

On the corresponding entity:

1. return if it does not have the corresponding field;
2. return if the field's `target_type` ≠ the saving entity's entity type;
3. return if the field's `handler_settings.target_bundles` is non-empty and does not contain
   the saving entity's bundle;
4. scan existing values for `target_id == $entity->id()`:
   - operation `add` and already present → **return** (idempotent, no duplicate);
   - operation `remove` → remember the index;
5. `remove`: `unset($values[$index])`; `add`: `array_unshift` (prepend) or `$values[] =`
   (append) a `['target_id' => $entity->id()]` item;
6. `$field->setValue($values); $correspondingEntity->save();`

## Practical consequences

- **Saving is what triggers it.** Changing config alone never rewrites existing content; to
  apply a new preset to existing entities you must re-save them (e.g. loop with
  `$node->save()`), because the *Synchronize* form does not do it.
- **The Synchronize form is broken** — `CorrespondingReferenceSyncForm::submitForm()` calls
  `$this->entity->delete()` and then reports "has been synchronized". Using it destroys the
  preset.
- Access is enforced normally: the corresponding entity is loaded and saved as the current
  user, so a user without update access to it produces no sync and no error.
- Nested saves are possible (A saves B, B's hooks fire). The `add` short-circuit in step 4
  prevents infinite recursion for a straight two-field pair.
- `unset($values[$index])` leaves a gap in the array keys; the field API re-indexes on
  `setValue()`, so deltas are renumbered.

## Applying a preset to existing content

```bash
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["type" => "article"]) as $node) {
    $node->save();   // triggers hook_entity_update -> CER sync
  }
'
```
