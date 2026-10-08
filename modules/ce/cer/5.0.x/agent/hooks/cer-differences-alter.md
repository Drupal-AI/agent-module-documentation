<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_cer_differences_alter()`

The only hook CER invites (`cer.api.php`). It fires once per corresponding field, after CER
has computed which references were added and removed and **before** it writes anything.

```php
/**
 * @param \Drupal\Core\Entity\ContentEntityInterface $entity
 *   The entity that was just saved/deleted (the one hosting the reference field).
 * @param array $differences
 *   ['add' => [entities...], 'remove' => [entities...]] — modify by reference.
 * @param string $correspondingField
 *   Machine name of the field on the *other* side that is about to be written.
 */
function hook_cer_differences_alter(ContentEntityInterface $entity, array &$differences, $correspondingField) {
  // Do not synchronize differences if entity is not published.
  if (!$entity->isPublished()) {
    $differences = ['add' => [], 'remove' => []];
  }
}
```

Invoked from `CorrespondingReference::synchronizeCorrespondingFields()` as
`\Drupal::moduleHandler()->alter('cer_differences', $entity, $differences, $correspondingField)`.

## Recipes

**Skip syncing for one field entirely**

```php
function mymodule_cer_differences_alter(ContentEntityInterface $entity, array &$differences, $correspondingField) {
  if ($correspondingField === 'field_locked_backrefs') {
    $differences = ['add' => [], 'remove' => []];
  }
}
```

**Never remove back-references, only ever add them**

```php
function mymodule_cer_differences_alter(ContentEntityInterface $entity, array &$differences, $correspondingField) {
  $differences['remove'] = [];
}
```

**Only correspond to entities of one bundle**

```php
function mymodule_cer_differences_alter(ContentEntityInterface $entity, array &$differences, $correspondingField) {
  foreach (['add', 'remove'] as $op) {
    $differences[$op] = array_filter($differences[$op], static fn($e) => $e && $e->bundle() === 'article');
  }
}
```

## Notes

- Entries may be **NULL** when a referenced entity no longer exists — CER itself checks
  `if ($correspondingEntity)` before writing, so guard your own filters the same way.
- The keys are the constants `CorrespondingReferenceOperations::ADD` (`'add'`) and
  `::REMOVE` (`'remove'`); keep both keys present.
- This is a classic `hook_..._alter()`, so in Drupal 11 you can implement it either as a
  `mymodule_cer_differences_alter()` function in `.module` or with the
  `#[Hook('cer_differences_alter')]` attribute on a class method.
- There are no other CER hooks and no events (`CerSubscriber` subscribes to nothing — it is
  an empty placeholder with a `@todo`).
