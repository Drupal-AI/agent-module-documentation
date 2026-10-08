# Drush commands

Defined in `src/Commands/SimpleCronCommands.php`, registered via `drush.services.yml` (service
`simple_cron.commands`, args `@entity_type.manager`, `@config.factory`). `composer.json` declares the
services for Drush `^9 || ^10`.

| Command | Aliases | Args / options | Action |
|---|---|---|---|
| `simple-cron` | `scron`, `simple-cron` | `<id>` (required); `--force` | Runs one enabled job by id. Applies `base.max_execution_time`, then calls `CronJob::run(time(), $force)`; logs completion/failure. |
| `simple-cron:list` | `scron:list`, `simple-cron:list` | `--status=enabled\|disabled`, `--format=table` | Lists all jobs as a table of `id` / `label` / `status`. |

## `simple-cron <id> [--force]`

- No id → throws: running all jobs is not supported; use core `drush core-cron` instead.
- Unknown id → throws `@name not found`.
- Disabled job → throws `The cron job "@name" is disabled`.
- `--force` skips the crontab schedule check (`shouldRun` force path). The per-job lock
  `simple_cron:<id>` is still respected — a locked job will not double-run.

```
ddev drush simple-cron cron.node          # run the cron.node job on schedule
ddev drush simple-cron cron.node --force  # run it now, ignoring the crontab
ddev drush scron queue.aggregator_feeds   # alias form
```

## `simple-cron:list [--status=]`

```
ddev drush simple-cron:list                 # all jobs
ddev drush scron:list --status=enabled      # only enabled jobs
ddev drush scron:list --status=disabled     # only disabled jobs
```

An invalid `--status` value throws (only `enabled` / `disabled` are accepted). Prints
`No cron jobs found.` when the filtered set is empty.
