<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron-service interfaces & error event

Implement one or more of these in your service class, then register it with tag `cron_service`. All
live in namespace `Drupal\cron_service` (`src/`).

## `CronServiceInterface` (required)

```php
public function execute();
```

The entry point. `CronServiceManager` calls it whenever the job is due. Runs on **every** cron run
if you implement only this interface (no schedule → `getScheduledCronRunTime()` returns 0 → always
due).

## `ScheduledCronServiceInterface extends CronServiceInterface`

```php
public function getNextExecutionTime(): int; // Unix timestamp
```

Return the timestamp **before which the job must not run**. After each run the manager stores this in
State (`cron_service.cron.<id>.schedule`) and skips the job until `now >= schedule`. Exact run time
still depends on when cron fires. Example: daily → `time() + 86400`.

## `TimeControllingCronServiceInterface extends CronServiceInterface`

```php
public function shouldRunNow(): bool;
```

A pre-run gate called on every run (unless the job is forced). Return FALSE to veto this run — use
for time-of-day / environment / feature-flag checks. Combined with a schedule, the job runs only when
the schedule is due **and** `shouldRunNow()` is TRUE.

## Combining

Interfaces combine freely; the manager runs `execute()` only when all applicable checks pass. Example
(from README):

```php
class YourJob implements ScheduledCronServiceInterface, TimeControllingCronServiceInterface {
  public function execute() { /* work */ }
  public function getNextExecutionTime(): int { return time() + 86400; }
  public function shouldRunNow(): bool { return /* condition */ TRUE; }
}
```

Service definition (`your_module.services.yml`):

```yaml
services:
  your_module.your_job:
    class: \Drupal\your_module\YourJob
    tags: [ { name: cron_service } ]
```

## `CronServiceErrorEvent` (`src/Event/CronServiceErrorEvent.php`)

Dispatched by `CronServiceManager::execute()` when a job's `execute()` throws. Extends
`Drupal\Component\EventDispatcher\Event`.

- `const EVENT_NAME = 'cron_service_error_event'` — subscribe to this.
- `getId(): string` — the failing service id.
- `getException(): \Exception` — the thrown exception.

Subscribe (e.g. to email/alert on failure) with a normal `EventSubscriberInterface` listening on
`cron_service_error_event`. The manager already logs the error to the `cron` channel; the event is
for custom reactions.
