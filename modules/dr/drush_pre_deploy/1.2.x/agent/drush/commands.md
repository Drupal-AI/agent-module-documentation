<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drush_pre_deploy — Drush commands

Service: `drush_pre_deploy.commands` = `Drupal\drush_pre_deploy\Commands\DrushPreDeployCommands`
(`drush.services.yml`), constructor args `%app.root%`, `%site.path%`, `@module_handler`,
`@keyvalue`, `@theme_handler`. Requires **Drush ≥ 10.3.0** (`composer.json` conflicts `drush/drush <10.3.0`;
services declared for Drush `^10 || ^11 || ^12`).

The command builds an anonymous subclass of core `\Drupal\Core\Update\UpdateRegistry`, sets its
updateType to **`predeploy`**, and points it at the keyvalue collection **`pre_deploy_hook`**. That
gives it core's deploy/post_update-style discovery of `MODULE.predeploy.php` files and per-environment
"already run" tracking.

| Command | Bootstrap | Purpose |
|---|---|---|
| `deploy:pre-hook-status` | full | Prints pending pre-deploy hooks. Fields: `module`, `hook`, `description`. Default filter field `hook`. Returns `RowsOfFields` (supports `--format=json`, `--fields`, etc.). |
| `deploy:pre-hook` | full | Runs pending pre-deploy hooks. Returns `0` (`EXIT_SUCCESS`) / `1` (`EXIT_FAILURE`). |

## `deploy:pre-hook` behaviour (from `run()` / `doRunPendingHooks()`)

1. Gets pending hook functions from the registry. If none: logs `No pending pre-deploy hooks.` and
   returns success.
2. Runs `deploy:pre-hook-status` as a subprocess and echoes the pending list.
3. Prompts: **"Do you wish to run the specified pending pre deploy hooks?"** — declining throws
   `UserAbortException` (non-zero exit). Use `-y`/`--yes` to auto-confirm in CI.
4. Unless `--simulate` is set, runs each pending hook via `\ReflectionFunction`:
   - Logs `Predeploy hook started: <fn>`.
   - Treats it as a batch: `$sandbox = []`, then `do { $return = $fn($sandbox); ... } while
     (isset($sandbox['#finished']) && $sandbox['#finished'] < 1);` — so a hook can process records in
     chunks by setting `$sandbox['#finished']` between 0 and 1.
   - A non-empty return value is logged as a notice.
   - After the loop, `registerInvokedUpdates([$fn])` marks it run in the `pre_deploy_hook` keyvalue.
5. Any `\Throwable` is caught, logged as `%type: @message in %function (line %line of %file).`
   (backtrace stripped), and the whole run returns failure. Hooks already marked complete before the
   failure stay complete; the failing/subsequent ones remain pending.

## Marking complete without running

`markComplete()` is `@hook pre-command deploy:mark-complete` — it has **no command of its own**. When
you run core's `drush deploy:mark-complete`, this fires first and calls
`registerInvokedUpdates($pending)` for all pending pre-deploy hooks, logging
`Marked %count pending pre-deploy hooks as complete.` Useful on a fresh environment where the
pre-deploy work is already reflected in the codebase/data and should not re-run.

## Typical invocations

```
drush deploy:pre-hook-status               # what will run
drush deploy:pre-hook --simulate           # dry run, no side effects
drush deploy:pre-hook -y                    # run, auto-confirm (CI)
drush deploy:pre-hook-status --format=json # machine-readable
drush deploy:mark-complete                 # also marks pre-deploy hooks done
```
