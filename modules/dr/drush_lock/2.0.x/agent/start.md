<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Lock (drush_lock) — agent index

Two **Drush commands** for acquiring/releasing named cross-process locks, so shell/deployment
scripts serialize instead of running a critical section concurrently. Package `Drush`. **No
routes, no UI, no permissions, no config, no dependencies** beyond Drush + Drupal core.
Core `^10 || ^11`. License GPL-2.0-or-later. Version **2.0.0-beta2** (pre-release beta,
not security-advisory-covered).

- **The two commands, options, aliases, and how the lock actually works** →
  [commands/lock-commands.md](commands/lock-commands.md)

## What it actually is

- One Drush command service `drush_lock.commands` (`drush.services.yml`, tag `drush.command`),
  class `Drupal\drush_lock\Commands\LockCommands` (`src/Commands/LockCommands.php`), constructed
  with `@lock` (core `LockBackendInterface`) and `@keyvalue` (`KeyValueFactoryInterface`, from
  which it takes the `drush_lock` collection).
- Two commands:
  - **`lock:wait <name> [--delay=30]`** (aliases `lwait`) — blocks until it claims the named
    lock or the `--delay` budget (seconds) is spent.
  - **`lock:release <name>`** (aliases `lrelease`, `lrel`) — clears the named lock.
- Locks are **pseudo locks** persisted as a boolean per name in the `drush_lock` key-value
  collection; they intentionally do **not** map to Drupal's per-process Locking API. The core
  lock service is used only as a short mutex (`self::GLOBAL_LOCK = 'drush_lock'`) to protect
  read-modify-write on that store.

## Mechanism (from source)

- `lockWait()` loops: acquire the global core lock; if the KV entry for `<name>` is falsy, set it
  TRUE and mark acquired; release the global lock. On miss it logs a notice and `sleep()`s a
  random 1–5s (escalating to 10s once it hits 5s), decrementing `--delay`; when `--delay` hits 0
  it stops. Returns `EXIT_SUCCESS` on acquire, `EXIT_FAILURE` if the budget ran out. `--delay` is
  clamped to a minimum of 1 with `max(intval(...), 1)`.
- `lockRelease()` acquires the global core lock (falling back to `lock->wait()`), reads the KV
  entry to know whether it existed, `delete()`s it, releases the global lock. Success if it
  existed, warning ("There was no lock named …") if not — **no ownership check**, by design (also
  usable to clear a stuck lock).
- Callers must honor the exit code: a non-zero `lock:wait` means the lock was NOT acquired.

## Notes / caveats

- Docblock `@usage` for `lock:wait` mistakenly shows `--wait=60`; the real option is `--delay`
  (see `@option delay`).
- No settings, no `config/` (so `provides_config_schema` is false); state lives in key-value, not
  config.
