<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service `entity_change_default_language`

Class `Drupal\entity_change_default_language\EntityChangeDefaultLanguage`
(interface `EntityChangeDefaultLanguageInterface`). Constructor deps: `logger.factory`,
`entity_type.manager`.

```php
public function update(
  ContentEntityInterface $entity,
  string $default_langcode,
  bool $create = FALSE,
  array $langcodes = []
): bool;
```

Changes the entity's **default/original** language to `$default_langcode`. Returns TRUE on success (or
no-op), FALSE if not applicable / on caught exception (logged).

## Parameters
- `$entity` — the content entity to re-base.
- `$default_langcode` — the langcode that should become the new default.
- `$create` — if TRUE and the entity has no translation in `$default_langcode`, one is created from the
  current default translation's values; if FALSE and the translation is missing, returns FALSE.
- `$langcodes` — translations to **preserve**. Any existing translation whose langcode is not in this
  list is removed. Pass `[]` to drop all non-default translations. Include the original langcode to keep
  the old default as a translation.

## Behavior / semantics
- Early-returns TRUE if the entity was already processed this request (static guard keyed by
  type+id), or if `$original_langcode == $default_langcode`. Returns FALSE if the entity is not
  translatable.
- Works off `$entity->getUntranslated()` (the current original). Builds the new default field values
  from the target translation (or from the original when creating), sets
  `content_translation_source` to `LANGCODE_NOT_SPECIFIED` on the new default.
- **Recurses** into every `entity_reference` / `entity_reference_revisions` field, calling `update()` on
  each referenced content entity with the same `$default_langcode`/`$create`/`$langcodes` (so a
  paragraph/reference tree is re-based together). The static guard prevents infinite loops / double
  processing.
- Only **translatable** field values are copied (`updateValues()`); `default_langcode` is never set
  directly. Preserved translations get `content_translation_source` set to the new default.
- Saves via `entitySave()`: forces `setNewRevision(FALSE)` and `setSyncing(TRUE)` — **no new revision**
  and content-translation sync side effects suppressed. May save more than once (to first remove a
  translation that will become the default).

## Caveats
- Not itself transactional; a failure mid-way is logged and returns FALSE but partial saves may have
  occurred. Test on a copy for large reference graphs.
- Because it saves with syncing on, hooks that key off normal saves/revisions may not fire as usual.
