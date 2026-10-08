<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Time Machine (date_point_time_machine) — agent index

Hidden helper submodule of **date_point** (`dependencies: date_point:date_point`). Makes the clock
mockable for tests/QA. Core `^11.3`. `hidden: true` — not for production.

## What it does
- `DatePointTimeMachineServiceProvider::alter()` aliases `date_point.clock` → `ProxyClock` and
  rebinds core `datetime.time` to `Datetime\Time` (a `TimeInterface` backed by one PSR-20 clock).
- `ProxyClock` (`Clock/ProxyClock`) delegates `now()` to a "real" clock whose service id is persisted
  in a temp file (hash-salted name; process-id varied under CLI kernel tests). API: `setRealClock()`,
  `getRealClock()`, `reset()`.
- Clock implementations (`services.yml`, all autowired): `FrozenClock` (ctor timestamp string),
  `MemoryClock` (static var), `StateClock` (Drupal state), `FileClock` (temp file), `SettingsClock`
  (`settings.php` key `date_point_time_machine`), `RandomClock` (bounded random). Named services
  `date_point_time_machine.clock.unix_epoch` and `.millennium` are pre-frozen `FrozenClock`s.
  `MemoryClock`/`StateClock`/`FileClock` implement `ClockHandlerInterface` (`get`/`set`/`reset`).
- Drush commands (`drush.services.yml`): `time-machine:travel-to <timestamp> [--clock-type=state|file]`
  (`Command\TravelToCommand`) and `time-machine:return` (`Command\ReturnCommand`).
- `Hook\Requirements` (`#[Hook('runtime_requirements')]`) shows current timestamp + active clock class
  on the status report. `hook_uninstall` resets the Proxy/File/State clocks.

## Docs
- Clocks, service wiring, commands, test patterns: `api/clocks.md`

Parent module index: `../../../../date_point/1.6.x/agent/start.md`
