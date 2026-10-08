<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clock Mock (dp_clock_mock) — agent index

**Deprecated** hidden helper submodule of **date_point** (`dependencies: date_point:date_point`;
`lifecycle: deprecated`). Deprecated in date_point 1.5.0, **removed in 2.0.0** — use
`date_point_time_machine` instead. Core `^11.3`, `hidden: true`, test/dev only.

## What it does (legacy)
- `DpClockMockServiceProvider` (`ServiceModifierInterface`): if a mock id is stored in a hash-salted
  temp file (`sys_get_temp_dir()/clock_mock.<type>.<hash>.txt`), rebinds `date_point.clock` and
  `date_point.clock.request` to it; a separate `time` mock rebinds `datetime.time`. Static helpers
  `setMock/getMock/resetMock('clock'|'time')` manage the file.
- Procedural helpers in `dp_clock_mock.module` (all `@deprecated`): `dp_clock_mock(?string $service)`
  and `dp_clock_mock_memory/state/file/settings()` (set clock + invalidate/rebuild container),
  `dp_time_mock(?string $service)` (set time service). Passing `NULL` resets.
- Clock services (`services.yml`, all marked `deprecated`): `dp_clock_mock.clock.unix_epoch`,
  `.millennium` (`FrozenClock`), `.memory` (`MemoryClock`), `.state` (`StateClock` ← `@state`),
  `.file` (`FileClock` ← `@settings`), `.settings` (`SettingsClock` ← `@settings`).
- `hook_uninstall` resets the file/state clocks and clears both mock files.

## Docs
- Service provider, functions, migration to Time Machine: `api/mock.md`

Parent module index: `../../../../date_point/1.6.x/agent/start.md`
Successor submodule: `../../../date_point_time_machine/1.6.x/agent/start.md`
