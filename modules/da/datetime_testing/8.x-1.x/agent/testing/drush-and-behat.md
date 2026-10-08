<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operating it: install, Drush commands, Behat context

## Install / enable

Install as a normal contrib module (`composer require drupal/datetime_testing`, then enable). No configuration, permissions, or UI. `hook_requirements()` in `datetime_testing.install` registers a **Warning**-severity status-report item ("Datetime Testing enabled — This module should not be enabled in production environments"). The project has no security-advisory coverage and the readme notes it may slow performance in production. Enable it only in dev/test/CI environments.

There is **no web route or form** that manipulates the clock — control is available only through the PHP service, Drush (CLI), or Behat (test harness).

## Drush commands (`Drush\Commands\TestTimeCommands`)

Registered as service `datetime_testing_request_time.commands` (tag `drush.command`); `create()` injects `datetime.time` (the decorated service, typed as `TestTimeInterface`).

- `datetime-testing:set <time> [timezone]` — parse `<time>` as `Y-m-d H:i:s` (via `DrupalDateTime::createFromFormat(DateTimePlus::FORMAT, ...)`), optional timezone (default UTC), and call `setTime($timestamp)`. Example: `drush datetime-testing:set '2020-01-15 12:00:00' 'Europe/Paris'`.
- `datetime-testing:get` — log the current reported time (formatted `Y-m-d H:i:s`, timestamp, timezone).
- `datetime-testing:freeze` — `freezeTime()`, then log the frozen moment.
- `datetime-testing:unfreeze` — `unfreezeTime()`.
- `datetime-testing:reset` — `resetTime()` (restores true time, unfreezes).

All commands report via `$this->logger()->success(...)`.

## Behat context (`Behat\DatetimeTestingContext`)

Extends `Drupal\DrupalExtension\Context\RawDrupalContext`. Register the subcontext path in `behat.yml` under `Drupal\DrupalExtension.subcontexts.paths` (pointing at the module dir); it does not need declaring under `contexts`. Step definitions:

- `Given the time/date is :time` / `Given the day is :time` / `When :time pass/passes` / `When :time of time pass/passes` → `timeIs()` → `\Drupal::time()->setTime($time)`.
- `Given the time/date is frozen as/at :time` / `Given the day is frozen as/at :time` → `timeIsFrozenAs()` → `freezeTime()` then `setTime($time)`.
- `Given time is frozen` → `timeIsFrozen()` → `freezeTime()`.
- `When time is unfrozen` → `timeIsUnfrozen()` → `unfreezeTime()`.
- `@AfterScenario` `resetTime()` → calls `\Drupal::time()->resetTime()` (guarded by a `moduleExists('datetime_testing')` check) so every scenario starts from the real clock.

See `features/time.feature` in the module for an end-to-end example scenario. Because `TestTime` persists state in keyvalue, a time set in one step or request is still in effect in later steps/requests of the same test run until reset.
