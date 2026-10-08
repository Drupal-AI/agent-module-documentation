# Maestro — Drush commands

Provided by `Drupal\maestro\Commands\MaestroCommands` (registered via `drush.services.yml`).

| Command | Aliases | Args | Does |
|---|---|---|---|
| `maestro:orchestrate` | `maestro-orchestrate`, `maestro-orch` | — | Runs the orchestrator: acquires the `maestro_orchestrator` lock (duration from `maestro_orchestrator_lock_execution_time`, default 30s), optionally enables development mode, then `MaestroEngine::cleanQueue()`. Exits FAILURE if the lock can't be acquired. |
| `maestro:start-process` | `maestro-start-process`, `maestro-start` | `<template_machine_name>` (required) | Starts a process from the (validated) template via `newProcess()`, then runs the orchestrator once. Errors if the template doesn't exist or won't start. |

```bash
ddev drush maestro:orchestrate
ddev drush maestro:start-process my_template
```

Use `maestro:orchestrate` from cron (instead of hitting `/orchestrator/<token>`) to advance running
processes on a schedule.
