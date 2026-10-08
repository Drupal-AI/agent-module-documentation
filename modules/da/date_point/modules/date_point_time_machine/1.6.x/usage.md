Time Machine is a hidden helper submodule of Date Point that swaps the clock services for a mockable ProxyClock so "now" can be frozen or shifted in automated tests and manual QA.

---

Enabling `date_point_time_machine` runs a service provider that aliases `date_point.clock` to a `ProxyClock` and replaces core's `datetime.time` with a PSR-20-backed mockable `Time` service, so both Date Point code and any core code reading `datetime.time` observe the same controllable clock. The proxy delegates to a "real" clock chosen at runtime; the module ships several PSR-20 implementations — `FrozenClock` (fixed/relative string), `MemoryClock` (static var, best for kernel tests), `StateClock` (Drupal state), `FileClock` (temp file, best for functional tests), `SettingsClock` (from `settings.php`), and `RandomClock` (random point in a range). Two drush commands, `time-machine:travel-to <timestamp>` and `time-machine:return`, let you shift a whole site's time for manual testing and revert it. A `runtime_requirements` hook surfaces the current mocked timestamp and the active clock class on the status report. The module is `hidden` and meant for test/dev environments — do not enable it on production. Its README documents cache-staleness pitfalls when rolling time backward within a test and the requirement to call `ProxyClock::reset()` in `tearDown()`.

---

- Freeze system time to a fixed instant in a kernel test via `MemoryClock`.
- Freeze time in a functional/JS test via `FileClock` or `StateClock` (survives sub-requests).
- Switch the active clock at runtime through `ProxyClock::setRealClock(FileClock::class)->set('2025-01-01 00:00:00+00:00')`.
- Reset the mocked clock back to real time in `tearDown()` with `ProxyClock::reset()`.
- Travel a whole site's "now" forward for QA: `drush time-machine:travel-to tomorrow`.
- Travel using a specific backing clock: `drush time-machine:travel-to "2030-01-01" --clock-type=file`.
- Return the site to present time: `drush time-machine:return`.
- Test `dp_date_time` "Created"/"Updated" field behavior deterministically.
- Test cron, scheduling, or expiry logic without waiting for real time to pass.
- Drive `RandomClock` to generate random-but-bounded timestamps in tests.
- Read the current mocked timestamp and active clock from the site status report.
- Provide a fixed epoch clock (`date_point_time_machine.clock.unix_epoch`) or millennium clock for edge-case tests.
- Set time from `settings.php` (`$settings['date_point_time_machine']`) via `SettingsClock`.
- Avoid cache-staleness bugs by always moving mocked time forward, or setting it before creating fields.
- Verify timezone-sensitive formatting by controlling the base instant.
