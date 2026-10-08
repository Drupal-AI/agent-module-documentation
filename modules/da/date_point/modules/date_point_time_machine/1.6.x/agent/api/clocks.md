<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Time Machine clocks & commands

Enable with `drush en date_point_time_machine` in a **test/dev** environment only. On enable, the
service provider takes over the clock; on uninstall, `hook_uninstall` calls `reset()` on the proxy,
file, and state clocks.

## Service takeover — `DatePointTimeMachineServiceProvider`
`alter(ContainerBuilder $container)`:
- `setAlias('date_point.clock', ProxyClock::class)` — Date Point's clock now resolves to the proxy.
- Rebinds the `datetime.time` definition to `Drupal\date_point_time_machine\Datetime\Time` with a
  single `@date_point.clock` argument, so **both** request-time and current-time methods read the
  proxy (unlike core, which separates request/current time).

## ProxyClock (`Clock/ProxyClock`, PSR-20)
Decorator that switches the underlying clock at runtime. The chosen service id is stored in a temp
file (`sys_get_temp_dir()`, name = `date-point-clock-<hash(hash_salt)>-<vary>.txt`; `vary` is the PID
under CLI kernel tests to avoid Paratest races). Methods:
- `setRealClock(string $service_id): ClockInterface` — persist + return the real clock.
- `getRealClock(): ClockInterface` — resolve stored id (default `date_point.clock.system`); throws
  `LogicException` if the service is missing or not a `ClockInterface`.
- `reset(): self` — reset the real clock (if a `ClockHandlerInterface`) and delete the state file.

## Clock implementations (`Clock/`, all PSR-20 `now()`)
| Service / class | Backing store | Handler? | Notes |
|---|---|---|---|
| `FrozenClock` | constructor string | no | Fixed instant; a relative string ("+1 day") is not truly frozen |
| `MemoryClock` | static property (`'now'` default) | yes | Best for kernel tests |
| `StateClock` | Drupal state (`date_point_time_machine.clock.state`) | yes | Survives sub-requests |
| `FileClock` | temp file (hash-salted name) | yes | Best for functional tests; may leave temp files |
| `SettingsClock` | `settings.php` `$settings['date_point_time_machine']` | no | Read-only |
| `RandomClock` | random within `[min,max]` (default `-1 year`..`+1 year`) | no | Bounded random instant |
| `date_point_time_machine.clock.unix_epoch` / `.millennium` | pre-frozen `FrozenClock` | no | `1970-01-01` / `2001-01-01` |

`ClockHandlerInterface`: `get(): string`, `set(string): self`, `reset(): self`.

## Drush commands (`drush.services.yml`)
- **`time-machine:travel-to <timestamp> [--clock-type=state|file]`** (`Command\TravelToCommand`,
  ctor `@ProxyClock`) — parses the timestamp (error on malformed), maps `--clock-type` to
  `StateClock`/`FileClock` (default `state`), calls `setRealClock(...)->set(ATOM)`.
- **`time-machine:return`** (`Command\ReturnCommand`, ctor `@ProxyClock`) — `proxyClock->reset()` and
  prints the restored present time.

## Test pattern (from README)
```php
$proxy = $this->container->get(ProxyClock::class);
$proxy->reset();                                   // clean previous state
$proxy->setRealClock(MemoryClock::class)->set('2025-01-01 00:00:00+00:00');
// ... assertions ...
protected function tearDown(): void {
  $this->container->get(ProxyClock::class)->reset(); // always reset
  parent::tearDown();
}
```
Always `reset()` before switching clocks and in `tearDown()`. Avoid rolling mocked time **backward**
within a test (cache-staleness of field definitions) — either always move forward, or set the time
before creating fields/entities.
