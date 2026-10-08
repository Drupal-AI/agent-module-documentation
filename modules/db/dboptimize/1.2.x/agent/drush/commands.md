<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DB Optimize — Drush commands

Two command classes registered in `drush.services.yml`. Run with `ddev drush …` on this project.

## Direct table operations — `DbOptimizeCommands` (`src/Commands/DbOptimizeCommands.php`)
Injected: `module_handler`, `database`. Each command calls `runCommandBatch(<STATEMENT>, $options['tables'])`,
which resolves tables from the comma-separated `--tables` option (trimmed) or `SHOW TABLES` when
omitted, then runs `"<STATEMENT> TABLE \`<table>\`"` per table and prints `Msg_type | Msg_text` rows
plus a success/fail summary.

| Command | Aliases | Statement |
|---------|---------|-----------|
| `dboptimize:optimize` | `dbo-optimize`, `dbo` | `OPTIMIZE TABLE` |
| `dboptimize:analyze`  | `dbo-analyze`  | `ANALYZE TABLE` |
| `dboptimize:check`    | `dbo-check`    | `CHECK TABLE` |
| `dboptimize:repair`   | `dbo-repair`   | `REPAIR TABLE` |

Option: `--tables=` comma-separated list; empty ⇒ all tables.
Examples:
```
drush dboptimize:optimize
drush dboptimize:optimize --tables=cache_data,watchdog
drush dbo-analyze --tables=node,users
```

## Cron handlers — `DbOptimizeDrushCommands` (`src/Commands/DbOptimizeDrushCommands.php`)
Injected: service `container`, `state`. These invoke the same `dboptimize.cron.<op>` services that
`hook_cron` uses (respecting the per-op frequency gate unless bypassed).

| Command | Aliases |
|---------|---------|
| `dboptimize:cron-optimize` | `dbo-cron-optimize` |
| `dboptimize:cron-analyze`  | `dbo-cron-analyze` |
| `dboptimize:cron-repair`   | `dbo-cron-repair` |
| `dboptimize:cron-check`    | `dbo-cron-check` |

Positional arg `$tables` (optional comma list, previewed only) and option `--bypass-last-run`
(sets `dboptimize.last_run.<op>` state to 0 so the frequency gate is skipped). `runOp()` fetches the
service, prefers `run($tables)` when the method takes an argument else `run()`/`__invoke()`, then
prints an execution summary (last run / duration / error). Returns exit code 0 on success, 1 on
failure.
```
drush dboptimize:cron-optimize --bypass-last-run
drush dbo-cron-check
```

The admin Help page (`dboptimize.commands` → `CommandsInfoController::overview`,
`/admin/config/system/dboptimize/help`) lists these commands with examples for reference.
