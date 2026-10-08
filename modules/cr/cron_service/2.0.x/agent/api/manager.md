<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CronServiceManager API (service `cron_service.manager`)

`\Drupal\cron_service\CronServiceManager` implements `CronServiceManagerInterface`
(`src/CronServiceManager.php`). Constructed with `@state`, `@logger.channel.cron`, `@datetime.time`,
`@event_dispatcher`. Registered as a `service_collector` for tag `cron_service`, so Drupal calls
`addHandler()` for every tagged service during container build.

## Collection

- `addHandler(CronServiceInterface $instance, string $id): void` — called by the container (via the
  `service_collector` tag); stores the instance in `$handlers[$id]`. **Do not call manually.** The
  `$id` is the service's container id.
- `getHandlerIds(): iterable` — `array_keys($handlers)`; list of registered service ids.

## Execution

- `execute(): void` — the cron entry point (`hook_cron()` calls it). Loops all handler ids and calls
  `executeHandler($id)` in a try/catch. On exception: logs an error and dispatches
  `CronServiceErrorEvent($id, $e)` (`CronServiceErrorEvent::EVENT_NAME` = `cron_service_error_event`).
  One failing job does not stop the rest.
- `executeHandler(string $id, $force = FALSE): bool` — runs a single job. If the id is unknown, logs
  a warning and returns FALSE. Otherwise runs when `$force` is TRUE **or** `shouldRunNow($id)` is
  TRUE: calls `$handler->execute()`, stores `last` = request time, reschedules
  (`scheduleNextRunTime()`), clears the forced flag, returns TRUE. If not due, logs a debug skip and
  returns FALSE. `$force = TRUE` bypasses all schedule/gate checks and runs immediately.
- `shouldRunNow(string $id): bool` — TRUE if the job is forced (`isForced()`); else
  `getScheduledCronRunTime($id) <= time()` **and** (for a `TimeControllingCronServiceInterface`) the
  job's own `shouldRunNow()`.

## Scheduling state (Drupal State)

Values stored via `state->set('cron_service.cron.<id>.<name>', …)`:

- `getLastExecutionTime(string $id): ?int` — reads `…last` (null if never run).
- `getScheduledCronRunTime(string $id): int` — reads `…schedule` (0) **only** if the handler is a
  `ScheduledCronServiceInterface`; otherwise returns 0 (i.e. always due).
- `scheduleNextRunTime()` (protected) — after a scheduled job runs, stores `…schedule` =
  `getNextExecutionTime()` then calls `state->resetCache()` (comment notes cache invalidation
  otherwise misbehaves).

## Forcing a single run

- `forceNextExecution(string $id): void` — sets `…forced` = TRUE. The job is **not** run immediately;
  on the next cron run `shouldRunNow()` returns TRUE and it runs bypassing schedule checks. Then
  `executeHandler()` calls `resetForceNextExecution()` (sets `…forced` = FALSE).
- `isForced(string $id): bool` — reads the `…forced` flag.

## Typical calls

```php
$m = \Drupal::service('cron_service.manager');
$m->executeHandler('my_module.cleanup');        // run if due
$m->executeHandler('my_module.cleanup', TRUE);  // run now, ignore schedule
$m->forceNextExecution('my_module.cleanup');    // run bypassing schedule on next cron
$next = $m->getScheduledCronRunTime('my_module.cleanup');
```

Note: `forceNextExecution()`/`executeHandler()` accept any string id; an unknown id only writes/reads
harmless State and logs a warning — the manager never runs a service that was not collected.
