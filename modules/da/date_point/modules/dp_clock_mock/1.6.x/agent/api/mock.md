<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clock Mock API (deprecated)

Legacy time-mocking for Date Point. **Prefer `date_point_time_machine`** — every service and function
here emits a deprecation notice and the module is removed in date_point 2.0.0. Test/dev only
(`hidden`).

## Service provider — `DpClockMockServiceProvider`
Implements `ServiceModifierInterface::alter()`:
- Reads a stored mock id via `getMock('clock')`; if set, replaces the `date_point.clock` and
  `date_point.clock.request` service **definitions** with that service.
- Reads `getMock('time')`; if set, replaces `datetime.time` (pointless without also mocking the clock).
- `setMock($type, $service)` / `getMock($type)` / `resetMock($type)` read/write/delete a file at
  `sys_get_temp_dir()/clock_mock.<clock|time>.<substr(sha256(hash_salt),0,16)>.txt`. Temp dir is used
  (not the `temporary://` scheme) because stream wrappers may be unavailable during partial bootstrap
  (e.g. DB updates); the salt is hashed because `/tmp` may be world-accessible.

## Helper functions (`dp_clock_mock.module`, all `@deprecated`)
- `dp_clock_mock(?string $service): ClockInterface` — set (or reset with `NULL`) the clock mock, then
  invalidate + rebuild the container and return `date_point.clock`.
- `dp_clock_mock_memory()` / `_state()` / `_file()` / `_settings()` — convenience wrappers selecting
  `dp_clock_mock.clock.memory|state|file|settings` and asserting the returned type.
- `dp_time_mock(?string $service): TimeInterface` — set/reset the `datetime.time` mock and rebuild.

## Clock services (`dp_clock_mock.services.yml`, each `deprecated`)
`dp_clock_mock.clock.unix_epoch` / `.millennium` (`FrozenClock`, frozen 1970 / 2001),
`.memory` (`MemoryClock`), `.state` (`StateClock` ← `@state`), `.file` (`FileClock` ← `@settings`),
`.settings` (`SettingsClock` ← `@settings`). `hook_uninstall` calls `reset()` on the file & state
clocks and clears both mock files (`dp_clock_mock(NULL)`, `dp_time_mock(NULL)`).

## Legacy usage
```php
\dp_clock_mock_file()->set('2024-09-30 18:45:53+00:00'); // mock Date Point clock
\dp_time_mock('date_point.time');                        // mock core time service
// cancel
\dp_clock_mock(NULL);
\dp_time_mock(NULL);
```

## Migration
Replace these calls with the successor submodule's `ProxyClock`:
`$container->get(ProxyClock::class)->setRealClock(FileClock::class)->set(...)` and `->reset()` in
`tearDown()`. See `../../../date_point_time_machine/1.6.x/agent/api/clocks.md`.
