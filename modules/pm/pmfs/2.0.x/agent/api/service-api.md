<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pmfs service API — guarding custom operations

The `pmfs` service (`Drupal\pmfs\Pmfs`, also available by class-name autowiring) lets custom
code reuse the same persistent-lock mechanism the module applies to forms, to keep a single
processing operation per visitor for an arbitrary operation id.

## The two calls you need
```php
/** @var \Drupal\pmfs\Pmfs $pmfs */
$pmfs = \Drupal::service('pmfs'); // or inject the 'pmfs' service / Drupal\pmfs\Pmfs.

// At the start of the operation:
if (!$pmfs->isCustomRequestExecutable('my_operation_id')) {
  // A lock is already held for this visitor + id → refuse.
  // isCustomRequestExecutable() has, by default, already queued an error message
  // (getCustomSettings()['message']) via the messenger. Pass FALSE to suppress it:
  //   $pmfs->isCustomRequestExecutable('my_operation_id', FALSE);
  return; // or a 409-style response, redirect, etc.
}

try {
  // ... do the guarded work exactly once ...
}
finally {
  // Mark the operation finished. If the matching config has skip_timeout = TRUE this
  // releases the lock immediately; otherwise the lock stays until its timeout expires.
  $pmfs->setCustomRequestDone('my_operation_id');
}
```

## Semantics
- `isCustomRequestExecutable($id, $show_message_on_deny = TRUE)`:
  - Returns `FALSE` if a lock for this visitor + id is currently unavailable (i.e. already
    acquired); optionally adds the configured error message.
  - Returns `TRUE` **and acquires the lock** (with the configured timeout) otherwise.
- `setCustomRequestDone($id)`: releases the lock **only when** that id's `skip_timeout` is
  `TRUE`; with `skip_timeout` `FALSE` the lock is left to expire after `timeout` seconds, so
  a repeat within the window is still blocked.
- Lower-level helpers exist too: `setLockByCustomId($id)`, `releaseCustomLock($id)`,
  `isCustomEnabled($id)`, `getCustomSettings($id)`.

## The lock key / per-visitor scope
The key is `pmfs.custom.<id>.<pmfs_key cookie>` (`Pmfs::getCustomLockKey()` →
`getLockKey('custom', $id)`). The `pmfs_key` cookie is set per visitor by the Cookie event
subscriber, so **locks are scoped to a single visitor** — one visitor's guard never blocks
another's. This is serialisation/idempotency per visitor, not a global mutex or a rate limiter.

## Configuration of a custom id
Each `<id>` reads config `pmfs.settings:custom.<id>` (status/timeout/skip_timeout/message),
falling back to the global defaults (`getDefaultValues()`) when unset. Entries appear in the
admin UI under "Custom request settings". If **development mode** is enabled, the first call
to `getCustomSettings($id)` for an unknown id auto-writes a default config entry so it becomes
visible/editable in the UI. `isCustomEnabled($id)` reflects the per-id `status` flag, but note
`isCustomRequestExecutable()` itself does not check `status` — call `isCustomEnabled()` first
if you want the guard to be toggleable from config.
