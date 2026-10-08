# Drush commands & lifecycle

Source: `src/Drush/Commands/MigrateBoostCommands.php` (+ `src/MigrateBoost.php`). Requires
Drush 13.

## Automatic activation

The command class registers `pre-command` hooks:

- `@hook pre-command migrate:import` → `boosterEnable()`
- `@hook pre-command migrate:rollback` → `boosterEnable()`

So simply running `drush migrate:import …` or `drush migrate:rollback …` activates boost for
that command; the configured `hooks` / `modules` are suppressed for its duration (the process
ends, and the next web request resets the flag anyway).

## Explicit commands

| Command | Aliases | Effect |
|---|---|---|
| `migrate:booster:enable` | `mbe`, `migrate-booster-enable` | `MigrateBoost::enable()` — set the active flag and reset the module-handler implementation cache. |
| `migrate:booster:reset` | `mbr`, `migrate-booster-reset` | `MigrateBoost::reset()` — reset the implementation cache (use if hook state seems stale mid-run). |

Both are `@validate-module-enabled migrate_boost`.

## `MigrateBoost` static API

| Method | Purpose |
|---|---|
| `enable()` | Turn boost on + `reset()`. |
| `disable()` | Turn boost off + `reset()`. |
| `bootDrupal()` | Alias for `disable()`, called on every `kernel.request`. |
| `reset()` | `\Drupal::moduleHandler()->resetImplementations()`. |
| `isBoostActive()` | Whether suppression is currently in effect. |

Because state is a process-static flag, boost never leaks into web requests; it exists only for
the lifetime of a Drush process where it was enabled.
