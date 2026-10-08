# API — content_lock

## The lock service

Service id `content_lock` (also aliased to the interface
`Drupal\content_lock\ContentLock\ContentLockInterface`), implemented by
`src/ContentLock/ContentLock.php`. Locks are stored in the `content_lock` database table
(schema in `content_lock.install`). Inject it or fetch with
`\Drupal::service('content_lock')`.

### Key methods (`ContentLockInterface`)

| Method | Purpose |
|---|---|
| `locking($entity, $form_op, $uid, $quiet = FALSE, $destination = NULL, &$messages = NULL): bool` | Try to lock the entity for `$uid`. Returns `TRUE` if now locked by this user, `FALSE` if already locked by someone else. Dispatches `ContentLockLockedEvent` on a fresh lock. |
| `fetchLock($entity, $form_op = NULL, $include_stale_locks = FALSE): object|false` | Return the current lock record (with `uid`, timestamp, etc.) or `FALSE`. |
| `isLockedBy($entity, $form_op, $uid): bool` | Whether the entity is locked by that specific user. |
| `release($entity, $form_op = NULL, $uid = NULL): void` | Release a lock (optionally only if it belongs to `$uid`). Dispatches `ContentLockReleaseEvent`. |
| `releaseAllUserLocks($uid): void` | Release every lock held by a user. |
| `releaseExpiredLocks(): int` | Release all locks past the configured stale timeout; returns the count released. |
| `isLockable($entity, $form_op = NULL): bool` | Whether this entity is configured to be locked (also runs `hook_content_lock_entity_lockable`). |
| `hasLockEnabled($entity_type_id): bool` | Whether any locking is configured for the entity type. |
| `isTranslationLockEnabled($entity_type_id): bool` | Whether the type locks at translation level. |
| `isFormOperationLockEnabled($entity_type_id): bool` | Whether form-operation-level locking is on for the type. |
| `displayLockOwner($lock, $translation_lock): string|TranslatableMarkup` | Human-readable "locked by …" message. |
| `unlockButton($entity, $form_op, $destination): array` | Render array for the unlock link/button. |
| `verbose(): bool` | Whether verbose messaging is enabled. |

Form-operation mode constants on the interface: `FORM_OP_MODE_DISABLED` (0),
`FORM_OP_MODE_ALLOWLIST` (1), `FORM_OP_MODE_DENYLIST` (2).

### Example — lock/release in code

```php
$content_lock = \Drupal::service('content_lock');
$uid = \Drupal::currentUser()->id();

// Try to lock a node for the current user on the 'default' form operation.
if ($content_lock->locking($node, 'default', $uid)) {
  // We hold the lock — safe to edit.
}

// Later, release it (only if it belongs to this user).
$content_lock->release($node, 'default', $uid);

// Housekeeping: drop every lock past the stale timeout.
$freed = $content_lock->releaseExpiredLocks();
```

## Hook — control lockability

`content_lock.api.php` defines one hook:

```php
function hook_content_lock_entity_lockable(
  \Drupal\Core\Entity\EntityInterface $entity,
  array $config,
  ?string $form_op = NULL,
): bool {
  // Return FALSE to make this entity un-lockable (existing locks are then ignored).
  if ($entity->getEntityTypeId() === 'node' && $entity->id() === 1) {
    return FALSE;
  }
  return TRUE; // Default: lockable.
}
```

Called from `isLockable()`. Returning `FALSE` makes Content Lock ignore/deny locking for that
entity, but it does **not** by itself prevent editing an un-lockable entity.

## Events

Dispatched by the service (`src/Event/`):

- `ContentLockLockedEvent` — when an entity becomes locked (carries entity id, langcode, form_op, uid, entity type id).
- `ContentLockReleaseEvent` — when a lock is released (built from the entity or from released query rows).

Subscribe with a normal event subscriber to react to locks/unlocks (e.g. logging, notifications).
