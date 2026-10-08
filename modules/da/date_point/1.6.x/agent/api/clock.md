<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clock, time service & CLI

Date Point standardises "reading the current time" on PSR-20 so time-dependent code is testable.
Defined in `date_point.services.yml`, `src/Clock/**`, `src/Time.php`, `src/date_point.php`,
`drush.services.yml`, `src/Command/**`.

## Services
- `date_point.clock` — a service **alias**, by default → `date_point.clock.system`. Also aliased to
  the interface id `Psr\Clock\ClockInterface`, so type-hinting `ClockInterface` autowires it.
- `date_point.clock.system` — `Clock\SystemClock` (`final readonly`). `now()` returns
  `new \DateTimeImmutable()`. Do **not** depend on it directly (unmockable); use `date_point.clock`.
- `date_point.clock.request` — `Clock\RequestClock`, built from `@request_stack`. `now()` returns the
  request start time (`REQUEST_TIME_FLOAT`) as a `DateTimeImmutable`.
- `date_point.time` — `Drupal\date_point\Time` (`final readonly`, implements core
  `Component\Datetime\TimeInterface`). Args: `[@date_point.clock, @date_point.clock.request]`.
  `getCurrentTime()`/`getCurrentMicroTime()` use the system clock; `getRequestTime()`/
  `getRequestMicroTime()` use the request clock. Use it where you want a mockable `TimeInterface`.

`Clock\ClockTrait::getClock()` returns `\Drupal::service('date_point.clock')` — used by field types
that need "now" (e.g. `created`/`updated` behavior) without constructor injection.

## Helper functions — `src/date_point.php` (namespace `Drupal\date_point`)
Loaded via `require_once` in `date_point.module`:
- `clock(): ClockInterface` — the `date_point.clock` service.
- `now(): \DateTimeImmutable` — `clock()->now()`.
- `time(): int` — `now()->getTimestamp()`.

## CLI commands (`drush.services.yml`, registered as `console.command`)
- **`date-point:now`** (alias `now`) — `Command\Now`, injected `@date_point.clock`. Options:
  `--modifier|-m` (a PHP relative date string applied via `->modify()`), `--format|-f`
  (default `Y-m-d H:i:s.vP`), `--timezone|-t` (converts before formatting). Bad modifier/timezone
  returns failure with an error message. Example: `drush now -m "+1 day" -t America/New_York`.
- **`date-point:clock-list`** (alias `clocks`) — `Command\ClockList`, injected `@service_container`
  (via `#[Autowire(service: 'service_container')]`) and `@datetime.time`. Prints two tables: core
  `TimeInterface` services (any service id containing `.time`) and PSR-20 `ClockInterface` services,
  each with class and current value; the active `datetime.time` / `date_point.clock` rows are
  highlighted. Services that cannot be instantiated outside their context (e.g. a controller) are
  skipped in a `try/catch` (v1.6.2 crash fix). Since Drupal 11.4 the commands are also discovered via
  `#[AsCommand]`; `ClockList` carries the explicit autowire attribute so discovery works either way.

## Overriding the clock
Enable the **Time Machine** submodule (`date_point_time_machine`) to swap `date_point.clock` for a
mockable `ProxyClock` and make `datetime.time` mockable too — see
`../../../modules/date_point_time_machine/1.6.x/agent/api/clocks.md`. Both mock submodules are
`hidden` and intended for tests/QA, not production.
