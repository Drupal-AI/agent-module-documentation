# Drush commands

Provided by `Drupal\ultimate_cron\Commands\UltimateCronCommands` (`drush.services.yml`).
All operate on `ultimate_cron_job` entities by machine name.

| Command | Aliases | What it does |
|---|---|---|
| `cron:list` | `crl`, `cron-list` | Table of jobs: id, module, schedule, last run, status. |
| `cron:run <job>` | `crun`, `cron-run` | Run one job (only if scheduled, unless `--force`). |
| `cron:logs <job>` | `cron-logs` | Show recent log entries for a job. |
| `cron:enable [<job>]` | `cre`, `cron-enable` | Enable a job (or `--all`). |
| `cron:disable [<job>]` | `crd`, `cron-disable` | Disable a job (or `--all`). |
| `cron:unlock [<job>]` | `cru`, `cron-unlock` | Clear a stale lock on a running job (or `--all`). |

Key options:
- `cron:list` — `--module=`, `--enabled`, `--disabled`, `--behind`, `--scheduled`,
  `--status=running,...`, `--extended`, `--name`.
- `cron:run` — `--force` (skip schedule check; locks still respected),
  `--options=thread=1` (per-plugin options).
- `cron:logs` — `--limit=N` (default 10), `--compact` (first line only).

```bash
drush cron:list --behind                 # jobs overdue
drush cron:run node_cron --force         # run a job now
drush cron:logs node_cron --limit=20     # last 20 runs
drush cron:disable --all                 # disable every job
```

Note: `cron:run` **without** a job name is rejected — to run all of cron use core's
`drush core:cron`. Legend in list/log output: `D` disabled, `R` running, `B` behind schedule.
