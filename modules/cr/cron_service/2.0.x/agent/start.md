<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Service Manager (cron_service) — agent index

Developer framework to replace `hook_cron()` implementations with **tagged service classes**. A
`service_collector` gathers every service tagged `cron_service` into `CronServiceManager`; the
module's `hook_cron()` calls `CronServiceManager::execute()`, which runs each collected service.
Optional interfaces add per-job **scheduling** and **run gating**. Version 2.0.5 (dir `2.0.x`).
Core `^10 || ^11`, PHP `>=8.0`, license GPL-2.0-or-later. No routes/config/permissions/UI in the
parent module. Ships one submodule, **cron_service_ui** (admin listing + force action).

- **The manager API — collect, execute, schedule, force, state storage** → [api/manager.md](api/manager.md)
- **The three cron-service interfaces + the error event** → [api/interfaces.md](api/interfaces.md)

## What it actually is (from source)

- Service `cron_service.manager` = `\Drupal\cron_service\CronServiceManager` (`cron_service.services.yml`),
  tagged `{ name: service_collector, tag: cron_service }`. Args: `@state`, `@logger.channel.cron`,
  `@datetime.time`, `@event_dispatcher`.
- `cron_service.module`: `hook_cron()` → `\Drupal::service('cron_service.manager')->execute()`.
  `hook_help()` is an empty stub. No routing/permissions/config/schema/install files exist.
- Interfaces in `src/`: `CronServiceInterface` (`execute()`), `ScheduledCronServiceInterface`
  (`getNextExecutionTime(): int`), `TimeControllingCronServiceInterface` (`shouldRunNow(): bool`).
- Event `\Drupal\cron_service\Event\CronServiceErrorEvent` (name `cron_service_error_event`),
  dispatched per failing job.

## How you use it

1. Write a class implementing `CronServiceInterface` (optionally the scheduled / time-controlling
   interfaces too).
2. Register it as a service with tag `cron_service` (the service id becomes the handler id).
3. On each cron run the manager runs it when its checks pass. Run/force one job on demand via the
   manager API — see [api/manager.md](api/manager.md).

## Notes

- Per-job state keys: `cron_service.cron.<id>.{last,schedule,forced}` in Drupal State.
- A job throwing is logged and turned into a `CronServiceErrorEvent`; other jobs still run.
- No config schema despite what any stale metadata says — the module stores nothing in config.
