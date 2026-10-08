Clock Mock is a deprecated, hidden helper submodule of Date Point for mocking system time in tests; use the Time Machine submodule instead.

---

`dp_clock_mock` provides a file-based mechanism for swapping Date Point's clock (and core's `datetime.time`) with a mock during tests. Its `DpClockMockServiceProvider` reads a mock service id from a hash-salted temp file and, if present, rebinds `date_point.clock` / `date_point.clock.request` (and optionally `datetime.time`) to that service; procedural helper functions (`dp_clock_mock()`, `dp_clock_mock_memory/state/file/settings()`, `dp_time_mock()`) write that file and rebuild the container. It ships `FrozenClock`, `MemoryClock`, `StateClock`, `FileClock`, and `SettingsClock` implementations. The whole module is **deprecated in date_point 1.5.0 and removed in 2.0.0** (`lifecycle: deprecated`), and every service emits a deprecation notice; new code should use `date_point_time_machine`, which exposes the same capability through a cleaner `ProxyClock` API and drush commands. The module is `hidden` and only for test/dev environments.

---

- (Legacy) Mock the Date Point clock in a test with `\dp_clock_mock_file()->set('2024-09-30 18:45:53+00:00')`.
- (Legacy) Mock core's time service with `\dp_time_mock('date_point.time')`.
- (Legacy) Use an in-memory clock via `\dp_clock_mock_memory()`.
- (Legacy) Use a Drupal-state-backed clock via `\dp_clock_mock_state()`.
- (Legacy) Use a settings-backed clock via `\dp_clock_mock_settings()`.
- (Legacy) Cancel all mocking with `\dp_clock_mock(NULL)` and `\dp_time_mock(NULL)`.
- Recognize the module when auditing an older project's test suite.
- Plan a migration off these functions onto `date_point_time_machine`'s `ProxyClock`.
- Understand that enabling it triggers deprecation notices on every clock service.
- Keep it out of production (hidden, test-only).
