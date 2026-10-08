<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Lock — the lock commands

Source: `src/Commands/LockCommands.php` (class `LockCommands extends DrushCommands`), wired in
`drush.services.yml` as service `drush_lock.commands` with `arguments: ['@lock', '@keyvalue']`
and tag `drush.command`.

## Install & enable

```bash
composer require drupal/drush_lock   # 2.0.0-beta2 (beta / minimum-stability may be needed)
drush en drush_lock -y
drush help lock:wait                  # confirm the commands are available
```

No configuration, no permissions, no dependencies beyond Drush + Drupal core (`^10 || ^11`).

## How locking works (two layers)

Drupal's core Locking API is per-PHP-process, so it cannot coordinate separate `drush`
invocations. This module therefore keeps **pseudo locks** in the key-value store and uses the
real lock service only as a brief mutex:

1. **Named lock state** — a boolean per lock name in the key-value collection `drush_lock`
   (`$keyValueFactory->get('drush_lock')`). A name that is set TRUE = "held".
2. **Mutex** — the core lock service (`@lock`, `LockBackendInterface`) with the fixed key
   `self::GLOBAL_LOCK = 'drush_lock'` guards each read-modify-write of that store so two processes
   don't claim the same name at once.

## `lock:wait <name> [--delay=<seconds>]` (aliases: `lwait`)

Method `lockWait($lock, $options = ['delay' => 30])`. Blocks until it acquires `<name>`.

- `--delay` is the max seconds to keep trying; clamped to at least 1 via `max(intval($options['delay']), 1)`.
- Loop each iteration: `lock->acquire('drush_lock')`; if held, read `keyValue->get($lock, FALSE)`;
  if falsy, `keyValue->set($lock, TRUE)` and mark acquired; then `lock->release('drush_lock')`.
- On a miss (name already held, or the mutex was busy): log a `notice`, then
  `sleep(rand(1,5))` with the sleep interval building up (`max($sleep, rand(1,5))`, capped at the
  remaining delay); each sleep is subtracted from the remaining `--delay`. Once a sleep reaches 5s
  it escalates to 10s intervals.
- When the remaining delay reaches 0 the loop breaks.
- Returns `CommandResult::exitCode(EXIT_SUCCESS)` and logs "Acquired lock …" on success, or
  `EXIT_FAILURE` and logs "Failed to acquire lock …" if the budget ran out.

Practical notes:
- **Callers must check the exit code** — a non-zero result means the lock was NOT acquired; the
  critical section should not proceed.
- `--delay=0` effectively means a single try (delay is clamped to 1, so one pass with almost no
  wait).
- Note the docblock `@usage` example wrongly writes `--wait=60`; the actual option is `--delay`.

## `lock:release <name>` (aliases: `lrelease`, `lrel`)

Method `lockRelease($lock)`. Clears `<name>`.

- Acquire the `drush_lock` mutex; if it can't, call `lock->wait('drush_lock')`. If that still
  reports the lock as held (returns TRUE), log an error ("Could not acquire access to lock store.
  Lock … was not released.") and return `EXIT_FAILURE`.
- Otherwise read `keyValue->get($lock, FALSE)` (to know if it existed), `keyValue->delete($lock)`,
  then `lock->release('drush_lock')`.
- Logs `success` ("Released lock …") if it existed, or `warning` ("There was no lock named …") if
  it did not. Returns `EXIT_SUCCESS` in both cases.
- **No ownership tracking**: any invocation can release any lock. This is intentional — it also
  lets an operator clear a stuck lock left by a crashed script.

## Typical usage

```bash
drush lock:wait my_deployment_lock --delay 1800 || exit 1   # wait up to 30 min, bail if not acquired
# ... updatedb, config:import, etc. (critical section) ...
drush lock:release my_deployment_lock
```

Give unrelated jobs distinct names so they don't block each other. Because a released lock is just
a deleted key-value entry, a lock left behind by a crash is cleared by re-running `lock:release`.
