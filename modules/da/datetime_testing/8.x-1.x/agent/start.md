<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datetime Testing (datetime_testing) — agent index

Developer/test-only API to control the time Drupal reports. It **decorates core's `datetime.time`** service so the "current time" can be **set / frozen / unfrozen / reset**, persisting the change in the **keyvalue** store so it survives across the many requests of a functional test. Not for production — `hook_requirements()` warns if enabled; no security-advisory coverage.

- **Version dir:** 8.x-1.x (`8.x-1.0-beta8`). **Core:** `^10 || ^11 || ^12`. **PHP:** `^8.3`.
- **Composer:** `drupal/datetime_testing`. No runtime module dependencies. Dev-only: `drupal/drupal-extension`, `drush/drush`.
- **No UI:** no routes, no permissions, no config entities/schema, no menu links, no blocks, no plugins.
- **No web-exposed clock control** — the clock is changed only via the PHP service API, Drush (CLI), or the Behat context.

## What it provides

- **Service `datetime_testing.test_time`** — `Drupal\datetime_testing\TestTime`, `public: false`, `decorates: datetime.time` (priority 5), args `@datetime_testing.test_time.inner`, `@keyvalue`. Implements `TestTimeInterface` (extends core `TimeInterface`). So `\Drupal::time()` returns it.
- **Class `TestDateTime`** — extends `DrupalDateTime`; parses `strtotime()`-style strings relative to the manipulated "now".
- **Drush commands** (`TestTimeCommands`, tagged `drush.command`): `datetime-testing:set`, `:get`, `:freeze`, `:unfreeze`, `:reset`.
- **Behat context** `DatetimeTestingContext` (extends `RawDrupalContext`) with natural-language time steps.

## Solution docs

- `agent/api/service.md` — the `TestTimeInterface` / `TestTime` API: set/freeze/unfreeze/reset, keyvalue keys, request-time handling.
- `agent/api/testdatetime.md` — the `TestDateTime` string-parsing helper.
- `agent/testing/drush-and-behat.md` — Drush commands and the Behat context/steps; install & the production warning.
